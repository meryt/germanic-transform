#!/usr/bin/python3

class InvalidCharError(Exception):
    '''Exception raised for unknown characters in the input'''
    def __init__(self, char, line):
        self.char = char
        self.line = line

class Utf8izer:
    '''Converts iso-8859-1 characters and HTML entities into their unicode equivalents'''
    known_chars = {131: 'É',
           133: '…',
           142: 'ĕ',
           150: '–',
           151: 'ó',
           156: 'ú',
           174: 'Æ',
           180: "'", # this is really a closing curly single quote
           190: 'æ',
           238: 'Ó'}
           
    def __init__(self, mappings_file_path):
        ''' Initialize the filter

        args:
            mappings_file_path : a path to the file containing the HTML-to-UTF-8 mappings.

        '''
        import sys
        import os.path
        from . import character_database

        self.known_codes = self.known_chars.keys()
        
        with (open(mappings_file_path, mode='r', encoding='utf-8')) as mapping_file:
            self.translations = character_database.read_mappings_file(mapping_file)

        # lowercase tags while we're at it
        self.translations.extend([('<I>','<i>'), ('</I>','</i>'), ('<B>','<b>'), ('</B>','</b>'), ('\\', '')])

        
    def utf8ify_extended_characters(self, string):
        '''Replaces all known extended characters from the source file with their UTF-8 equivalent'''
        buf = ''
        for char in list(string):
            if ord(char) > 128:
                if ord(char) not in self.known_codes:
                    raise InvalidCharError(char, line)
                else:
                    buf += self.known_chars[ord(char)]
            else:
                buf += char
        return buf

    def utf8ify_html_characters(self, string):
        '''Replaces HTML character codes with their UTF-8 equivalent characters'''
        for srch, replace in self.translations:
            string = string.replace(srch, replace)
        return string

    def filter(self, string):
        string = self.utf8ify_extended_characters(string)
        string = self.utf8ify_html_characters(string)
        return string

if __name__ == '__main__' and __package__ is None:
    ''' Hack to allow relative imports from within the packege '''
    import sys, os
    parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    sys.path.insert(0, parent_dir)
    import impgermanic
    __package__ = str("impgermanic")
    del sys, os

if __name__ == '__main__':
    ''' Now run the actual script '''
    import argparse
    import sys
    import os.path
    absroot = os.path.dirname(os.path.abspath(__file__))

    parser = argparse.ArgumentParser(description='Converts HTML-encoded characters into their UTF-8 equivalents')
    parser.add_argument('-f', '--file', default="-", help='the input file containing the HTML to be converted or - for stdin')
    parser.add_argument('-o', '--output', help='the output file which will be in UTF-8, or stdout if not provided')
    parser.add_argument('-m', '--mappings', required=True, help="the location of the HTML-to-UTF-8 mappings file")
    args = parser.parse_args()

    infileDescriptor = sys.stdin.fileno() if args.file == '-' else args.file

    with (open(infileDescriptor, 'r', encoding='utf-8')) as infile:
        with (sys.stdout if args.output == None else open(args.output, mode='w', encoding='utf-8')) as outfile:
            filter = Utf8izer(args.mappings)
            for line in infile:
                outfile.write(filter.filter(line))
    

    