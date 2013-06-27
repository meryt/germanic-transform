#!/usr/bin/python3

import re

class InvalidCharacterDatabaseError(Exception):
    '''Error in processing character database file'''

def get_character_translations(dfile):
    '''Gets a list of HTML entity / unicode character(s) tuples'''
    chars = []
    # Get non-zero-length lines that aren't comments
    lines = [line for line in dfile if len(line.strip()) and line[0] != '#']
    for line in lines:
        # Split on whitespace
        fields = line.split()
        if len(fields) >= 2:
            html_entity = fields[1]
            unicode_replacement = fields[0]
            if re.search('^&.*;$', html_entity):
                # Some unicode characters don't exist yet
                if unicode_replacement == '-':
                    # Check for '&a-sup;'-type characters
                    matches = re.search('^&([a-zA-Z0-9])-(sub|super);$', html_entity)
                    if matches and len(matches.groups()) >= 2:
                        # replace with <sup> or <sub> tags
                        tag = matches.group(2)
                        letter = matches.group(1)
                        replace = '<' + tag + '>' + letter + '</' + tag + '>'
                    else:
                        # Keep the HTML escape entity, so we don't lose info
                        replace = html_entity
                    chars.append((html_entity, replace))
                else:
                    unicode_str = unicode_entry_to_unicode_chars(unicode_replacement)
                    chars.append((html_entity, unicode_str))
            else:
                raise InvalidCharacterDatabaseError("Malformed html entity: " + html_entity)
        else:
            raise InvalidCharacterDatabaseError("Invalid non-comment line: " + line)
    return chars

def unicode_entry_to_unicode_chars(unicode_entry):
    '''Convert an entry in the form of 'U2941+U0303' to a string of unicode chars'''
    # Unicode entries in the character database are like
    # 'U2014' or 'U2014+U0301' - namely, upper-case U plus
    # 4 hexadecimal digits, followed by zero or more
    # similar groups separated by '+' signs
    matches = re.search('''
        ^U[0-9a-fA-F]{4}        # Start with unicode char
        (
            \+U[0-9a-fA-F]{4}   # additional unicode char(s)
        )*                      # 0 or more times
        $                       # end string
        ''', unicode_entry, re.VERBOSE)
    if matches:
        codes = unicode_entry.replace('U','').split('+')
        # If it's a proper unicode entry in the format of
        # this file, add it as a true unicode string of
        # 1 or more unicode characters.
        unicode_str = ''.join(    # combine into single string
            [chr(                 # convert int to unicode char
                int(g,16)         # convert 4-hex-digit string (from regex match) to decimal int
             )
             for g in codes if g  # skip any None entries
            ]
          )
    else:
        raise InvalidCharacterDatabaseError("Invalid unicode sequence: " + unicode_entry)

    return unicode_str

def write_mappings_file(chars, output_file):
    '''Writes the converted character mapping to a file or stdout'''
    for tuple in chars:
        output_file.write(tuple[0] + "\t" + tuple[1] + "\n")

def read_mappings_file(input_file):
    '''Reads the converted character mapping from a file and returns as a list of tuples'''
    chars = []
    for line in [line.rstrip("\n") for line in input_file]:
        # Split on whitespace
        fields = line.split("\t")
        if len(fields) == 2:
            chars.append((fields[0], fields[1]))
        else:
            raise InvalidCharacterDatabaseError("Invalid mapping file line: " + line)
    return chars

def _test(infile):
    '''Test on the character database'''

    # Test on some strings
    str = 'U0061+U0301+U0328'
    assert(len(unicode_entry_to_unicode_chars(str)) == 3)
    str = 'U0061+U0301'
    assert(len(unicode_entry_to_unicode_chars(str)) == 2)
    str = 'U0061'
    assert(len(unicode_entry_to_unicode_chars(str)) == 1)

    char_tuples = get_character_translations(infile)

    with open('./.test.txt', mode='w', encoding='utf-8') as outfile:
        write_mappings_file(char_tuples, outfile)

    with open('./.test.txt', mode='r', encoding='utf-8') as infile2:
        char_tuples_two = read_mappings_file(infile2)

    if len(char_tuples) != len(char_tuples_two):
        raise Exception("Original list has {0} elements but deserialized list has {1} elements".format(
            len(char_tuples), len(char_tuples_two)))

    for i in range(0,len(char_tuples) - 1):
        if char_tuples[i][0] != char_tuples_two[i][0]:
            raise Error("Error matching keys in output line {}".format(i + 1))
        if char_tuples[i][1] != char_tuples_two[i][1]:
            raise Exception("Error matching values in output line {0}: was {1} is {2}".format(
                i + 1, char_tuples[i][1], char_tuples_two[i][1]))

    for char_tuple in char_tuples_two:
        print(char_tuple)

if __name__ == '__main__':
    import argparse
    import os.path
    import sys

    parser = argparse.ArgumentParser(description='Generate the character database')
    parser.add_argument('-t', '--test', action='store_true', help='run the unit test and exit')
    parser.add_argument(dest='file', metavar='<file>', nargs='?', default="-", help='the file containing the ASCII input character database (or none for stdin)')
    parser.add_argument('-o', '--output', help='the file where the UTF-8 mappings will be stored, or stdout if not provided')
    args = parser.parse_args()

    fileDescriptor = sys.stdin.fileno() if args.file == '-' else args.file

    infile  = open(fileDescriptor, 'r', encoding='iso-8859-1') # We know the expected input to be iso-8859-1
    outfile = sys.stdout if args.output == None else open(args.output, mode='w', encoding='utf-8')

    if (args.test):
        _test(infile)
    else:
        write_mappings_file(get_character_translations(infile), outfile)

