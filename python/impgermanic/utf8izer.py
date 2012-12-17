#!/usr/bin/python3

import sys
import os.path
from . import character_database


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
           
    def __init__(self):
        self.known_codes = self.known_chars.keys()
        self.translations = character_database.get_character_translations()
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

