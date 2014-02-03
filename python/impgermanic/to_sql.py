#!/usr/bin/python3
from collections import deque
import re
import sys
import os
import sqlite3
import cProfile, pstats, io

debug_flag = False

class ParseError(Exception):
    '''Error in the parsing of the data file'''

class DataConverter():

    def convert(self, infile, dataWriter):
        '''Convert an input text file to some database format.

        args:
            infile - an open file handle
            DataWriter datawriter - an instance of DataWriter which stores the data in some sort of database
        '''

        # Read into a deque since we may need pushback.
        lines = deque(infile.readlines())
        lines_read = 0
        lines_read += self.consume_introduction(lines)

        # Simple data structure to keep track of what we're currently reading.
        # We will occasionally send dump this to the writer as we go
        entry = {
            'cur_page': None,
            'cur_entry': None,
            'cur_entry_page': None,
            'cur_entry_raw': '',
            'cur_entry_text': '',
            'cur_entry_line': []
        }

        regexes = {
            'page_num':      re.compile('<PAGE NUM="([bd][0-9]{4})'),
            'letter_header': '<letterheader>([A-Z])</letterheader>',
            'header':        '<HEADER>([0-9]+ +)?(.*?[^. ])\.? *([0-9]+ *)?\.?</HEADER>',
            'entry_start':   '^<[Bb]>([^,.]*?)[;,.]*</[Bb]>',
            'header_separator': '( +--? +| *-- *)'
        }

        dataWriter.start()

        # Line numbers will be one-based, incremented immediately after read, so start at
        # 0 since we haven't read anything yet.
        i = 0
        while 0 < len(lines):
            line = lines.popleft()  #.strip()
            line_raw = line
            i += 1

            # Look for page
            if 0 == len(line):
                continue # consume line, do nothing
            elif regexes['page_num'].search(line):
                # I believe this means an entry that spans pages is listed as appearing
                # on its last page.
                entry['cur_page'] = regexes['page_num'].search(line).groups()[0]
                # debug_write("Read page number " + entry['cur_page'] + "\n")
                continue # consume line
            elif re.search(regexes['letter_header'], line):
                if entry['cur_entry']:
                    dataWriter.write_entry(entry)
                # Start a new entry
                entry_name = re.search(regexes['letter_header'], line).groups()[0]
                debug_write("Found letter header " + entry_name)
                self.start_entry(entry, entry_name, line, line_raw, i)
                continue # consume line
            elif re.search(regexes['header'], line):
                header = re.search(regexes['header'], line).groups()[1]
                header = re.sub(regexes['header_separator'], ' – ', header)
                dataWriter.write_header(header, entry['cur_page'], i)
                continue # consume line
            elif re.search(regexes['entry_start'], line):
                # dump current entry before starting a new one
                if entry['cur_entry']:
                    dataWriter.write_entry(entry)
                # start a new entry
                entry_name = re.search(regexes['entry_start'], line).groups()[0]
                self.start_entry(entry, entry_name, line, line_raw, i)
                continue
            else:
                # Appears to be a continuation of the current entry
                # Trim off trailing </p>\n
                entry['cur_entry_text'] = entry['cur_entry_text'][0:-5] + line + '</p>\n'
                entry['cur_entry_raw'] += line_raw
                if (1 >= len(entry['cur_entry_line'])):
                    entry['cur_entry_line'].append(str(i))
                else:
                    entry['cur_entry_line'][1] = (str(i))
                #debug_write("Added line to current entry " + entry['cur_entry'] + "\n")
                continue

            raise ParseError('Unexpected input: ' + line)


        # Write the last entry hanging out in the data structure
        if (entry['cur_entry_text']):
            dataWriter.write_entry(entry)

        dataWriter.end()

    def start_entry(self, entry, entry_name, line, line_raw, line_num):
        entry['cur_entry'] = entry_name
        entry['cur_entry_text'] += '<p>' + line + '</p>\n'
        entry['cur_entry_raw'] += line_raw
        entry['cur_entry_page'] = entry['cur_page']
        entry['cur_entry_line'] = [str(line_num)]
        #debug_write("Started new entry " + entry['cur_entry'] + "\n")


    def consume_introduction(self, lines):
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


class DataWriter():

    def __init__(self, outfile):
        self.headers = []
        self.entries = []
        self.outfile = outfile

    def write_header(self, header_line, page_id, line_num):
        self.headers.append("('{0}', '{1}', '{2}')"
            .format(self.sql_escape(page_id), self.sql_escape(header_line), line_num))
        #debug_write("New header " + header_line)

    def write_entry(self, entry):
        self.entries.append("('{0}', '{1}', '{2}', '{3}', '{4}')".format(
            self.sql_escape(entry['cur_entry_page']),
            self.sql_escape(entry['cur_entry']),
            self.sql_escape(entry['cur_entry_raw']),
            self.sql_escape(entry['cur_entry_text']),
            self.sql_escape(','.join(entry['cur_entry_line']))
         ))
        entry['cur_entry_text'] = ''
        entry['cur_entry_raw'] = ''
        #debug_write("Wrote entry " + entry['cur_entry'] + "\n")

    def start(self):
        pass

    def end(self):
        self.datafile_to_sql(self.outfile)

    def datafile_to_sql(self, outf):
        '''Convert the utf-8-converted file to a MySQL import script'''

        outf.write("/* Requires SUPER; Execute with --max_allowed_packets=500M on the command line */\n\n")
        outf.write("TRUNCATE TABLE pages; TRUNCATE TABLE entries;\n\n")
        outf.write("set global max_allowed_packet=1000000000; set global net_buffer_length=1000000;\n\n")
        outf.write("SET NAMES utf8; SET FOREIGN_KEY_CHECKS=0;\n\n")

        outf.write('INSERT INTO pages (id, header, line_num) VALUES\n')
        outf.write(",\n".join(self.headers) + ";\n\n")

        outf.write("INSERT INTO entries (page_id, headword, entry_raw, entry, line_num) VALUES\n")
        outf.write(",\n".join(self.entries) + ";\n\n")

    def sql_escape(self, st):
        return st.replace("'", "''")

class MysqlWriter(DataWriter):
    pass

class SqliteWriter(DataWriter):

    def start(self):
        try:
            # Remove the file before creating it; we always start fresh.
            os.remove(self.outfile)
        except OSError:
            pass
        self.db = sqlite3.connect(self.outfile)
        c = self.db.cursor()
        c.execute('''CREATE TABLE pages (id INT PRIMARY KEY, header TEXT, line_num TEXT)''');
        c.execute('''CREATE TABLE entries (page_id INT, headword TEXT, entry_raw TEXT, entry TEXT, line_num TEXT)''');
        self.db.commit()

    def write_entry(self, entry):
        # Create a new dictionary using only the keys we are interested in, and append it to the entries list
        self.entries.append({k:entry[k] for k in ['cur_entry_page', 'cur_entry', 'cur_entry_raw', 'cur_entry_text', 'cur_entry_line']})
        entry['cur_entry_text'] = ''
        entry['cur_entry_raw'] = ''

    def end(self):
        self.datafile_to_sql()
        self.db.close()

    def datafile_to_sql(self):
        c = self.db.cursor()
        for chunk in self.chunk_headers(100):
            c.execute('''INSERT INTO pages (id, header, line_num) VALUES ''' + ','.join(chunk))
        for entry in self.entries:
            params = (entry['cur_entry_page'], entry['cur_entry'], entry['cur_entry_raw'], entry['cur_entry_text'], ','.join(entry['cur_entry_line']))
            c.execute('''INSERT INTO entries (page_id, headword, entry_raw, entry, line_num) VALUES (?, ?, ?, ?, ?)''', params)
        self.db.commit()

    def chunk_headers(self, chunk_size):
        for i in range(0, len(self.headers), chunk_size):
            yield self.headers[i:i+chunk_size]


def debug_write(str):
    if debug_flag:
        print(str)

if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Converts a UTF-8-encoded lexicon file into some database format (currently MySQL Dump)')
    parser.add_argument('-t', '--type', default="mysql", help='the format of the output file -- accepts "mysql" and "sqlite"')
    parser.add_argument('-f', '--file', default="-", help='the input file containing the lexicon to be converted, or nothing or - for stdin')
    parser.add_argument('-o', '--output', help='the output file, or stdout if not provided')
    args = parser.parse_args()

    converter = DataConverter()
    infileDescriptor = sys.stdin.fileno() if args.file == '-' else args.file

    if (args.type.lower() == 'sqlite'):
        writer = SqliteWriter(args.output)
        with (open(infileDescriptor, 'r', encoding='utf-8')) as infile:
                #pr = cProfile.Profile()
                #pr.enable()
                converter.convert(infile, writer)
                #pr.disable()

                #s = io.StringIO()
                #sortby = 'cumulative'
                #ps = pstats.Stats(pr, stream=s).sort_stats(sortby)
                #ps.print_stats()
                #print(s.getvalue())
    else:
        outfileDescriptor = sys.stdout.fileno() if args.output == None else args.output
        with (open(infileDescriptor, 'r', encoding='utf-8')) as infile:
            with open(outfileDescriptor, mode='w', encoding='utf-8') as outf:
                writer = MysqlWriter(outf)
                try:
                    converter.convert(infile, writer)
                except ParseError as e:
                    sys.stdout.write(e.args[0])
                    exit(1)

