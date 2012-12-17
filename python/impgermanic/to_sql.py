#!/usr/bin/python3
from collections import deque
import re
import sys
from . import utf8izer

debug_flag = False

class ParseError(Exception):
    '''Error in the parsing of the data file'''

def datafile_to_sql(infile, outfile):
    '''Convert the utf-8-converted file to a MySQL import script'''
    
    # read the whole thing into memory
    with open(infile, mode='r', encoding='iso-8859-1') as inf:
        # Go into a deque in case we need to push lines back onto the front of
        # the queue
        lines = deque([l for l in inf.readlines()])

    i = 0

    i += consume_introduction(lines)
    debug_write("Read introduction.\n")
    if debug_flag:
        print("Introduction ended line {0}".format(i))

    # Simple data structure to keep track of what we're currently reading.
    # We will occasionally dump parts of this to the SQL file as we go.
    entry = {
        'cur_page': None,
        'cur_entry': None,
        'cur_entry_page': None,
        'cur_entry_raw': '',
        'cur_entry_text': '',
        'cur_entry_line': []
    }
    
    regexes = {
        'page_num':      '<PAGE NUM="([bd][0-9]{4})',
        'letter_header': '<letterheader>([A-Z])</letterheader>',
        'header':        '<HEADER>([0-9]+ +)?(.*?[^. ])\.? *([0-9]+ *)?\.?</HEADER>',
        'entry_start':   '^<[Bb]>([^,.]*?)[;,.]*</[Bb]>'
    }

    utf8izer_filter = utf8izer.Utf8izer()

    headers = []
    entries = []

    while 0 < len(lines):
        if debug_flag:
            cont = input("More? [y|n]: ")
            if ('y' != cont):
                break

        line_raw = lines.popleft()
        line = utf8izer_filter.filter(line_raw.strip())
        i += 1
        if debug_flag:
            print("Line {0}".format(i))

        # Look for page
        if 0 == len(line):
            continue # consume line, do nothing
        elif re.search(regexes['page_num'], line):
            entry['cur_page'] = re.search(regexes['page_num'], line).groups()[0]
            debug_write("Read page number " + entry['cur_page'] + "\n")
            continue # consume line
        elif re.search(regexes['letter_header'], line):
            if entry['cur_entry']:
                write_entry(entries, entry)
            # Start a new entry
            entry_name = re.search(regexes['letter_header'], line).groups()[0]
            start_entry(entry, entry_name, line, line_raw, i)
            continue # consume line
        elif re.search(regexes['header'], line):
            header = re.search(regexes['header'], line).groups()[1]
            write_header(headers, header, entry['cur_page'], i)
            continue # consume line
        elif re.search(regexes['entry_start'], line):
            # dump current entry before starting a new one
            if entry['cur_entry']:
                write_entry(entries, entry)
            # start a new entry
            entry_name = re.search(regexes['entry_start'], line).groups()[0]
            start_entry(entry, entry_name, line, line_raw, i)
            continue
        else:
            # Appears to be a continuation of the current entry
            cur_text = re.sub('</p>\n$', ' ', entry['cur_entry_text']) + line + '</p>\n'
            entry['cur_entry_text'] = cur_text
            entry['cur_entry_raw'] += line_raw
            if (1 >= len(entry['cur_entry_line'])):
                entry['cur_entry_line'].append(str(i))
            else:
                entry['cur_entry_line'][1] = (str(i))
            debug_write("Added line to current entry " + entry['cur_entry'] + "\n")
            continue

        raise ParseError('Unexpected input: ' + line)

    # Write the last entry hanging out in the data structure
    if (entry['cur_entry_text']):
        write_entry(entries, entry)
            
            
    with open(outfile, mode='w', encoding='utf-8') as outf:
        outf.write("/* Requires SUPER; Execute with --max_allowed_packets=500M on the command line */\n\n")
        outf.write("TRUNCATE TABLE pages; TRUNCATE TABLE entries;\n\n")
        outf.write("set global max_allowed_packet=1000000000; set global net_buffer_length=1000000;\n\n")
        outf.write("SET NAMES utf8; SET FOREIGN_KEY_CHECKS=0;\n\n")
                
        outf.write('INSERT INTO pages (id, header, line_num) VALUES\n')
        outf.write(",\n".join(headers) + ";\n\n")
        
        outf.write("INSERT INTO entries (page_id, headword, entry_raw, entry, line_num) VALUES\n")
        outf.write(",\n".join(entries) + ";\n\n")

def consume_introduction(lines):
    '''Read INTRODUCTION tag and everything until end tag, return number of lines read'''
    lines_read = 0
    to_finds = deque(['<INTRODUCTION>', '</INTRODUCTION>'])
    to_find = to_finds.popleft()
    while 0 < len(lines):
        line = lines.popleft()
        lines_read += 1
        if to_find in line:
            if 0 == len(to_finds):
                return lines_read
            else:
                to_find = to_finds.popleft()
    return lines_read

def sql_escape(str):
    return str.replace("'", "''")

def debug_write(str):
    if debug_flag:
        sys.stderr.write(str)

def start_entry(entry, entry_name, line, line_raw, line_num):
    entry['cur_entry'] = entry_name
    entry['cur_entry_text'] += '<p>' + line + '</p>\n'
    entry['cur_entry_raw'] += line_raw
    entry['cur_entry_page'] = entry['cur_page']
    entry['cur_entry_line'] = [str(line_num)]
    debug_write("Started new entry " + entry['cur_entry'] + "\n")    

def write_entry(entry_list, entry):
    entry_list.append("('{0}', '{1}', '{2}', '{3}', '{4}')".format(
        sql_escape(entry['cur_entry_page']),
        sql_escape(entry['cur_entry']), 
        sql_escape(entry['cur_entry_raw']),
        sql_escape(entry['cur_entry_text']),
        sql_escape(','.join(entry['cur_entry_line']))
     ))
    entry['cur_entry_text'] = ''
    entry['cur_entry_raw'] = ''
    debug_write("Wrote entry " + entry['cur_entry'] + "\n")
    

def write_header(header_list, header_line, page_id, line_num):
    header = re.sub('( +--? +| *-- *)', ' – ', header_line)
    header_list.append("('{0}', '{1}', '{2}')"
        .format(sql_escape(page_id), sql_escape(header), line_num))
    debug_write("Read and wrote new header " + header + "\n")


if __name__ == '__main__':
    import os.path
    import sys

    absroot = os.path.dirname(os.path.abspath(__file__))
    in_file = os.path.join(absroot, '../../data/oe_bosworthtoller.txt')

    try:
        utf8file_to_sql(in_file, 'foo')
    except ParseError as e:
        debug_write(e.args[0])
        exit(1)
        
    print("OK")

