#!/usr/bin/python3

import re

class InvalidCharacterDatabaseError(Exception):
    '''Error in processing character database file'''

def get_character_translations(def_file = None):
    '''Gets a list of HTML entity / unicode character(s) tuples'''
    chars = []
    if not def_file:
        import os.path
        absroot = os.path.dirname(os.path.abspath(__file__))
        def_file = os.path.join(absroot, '../../../germanic-lexicon/character_database.txt')
    with open(def_file, mode='r', encoding='iso-8859-1') as dfile:
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
    # 4 hexadecimal digigts, followed by zero or more 
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


if __name__ == '__main__':
    '''Test on the character database'''
    import os.path

    # Test on some strings
    str = 'U0061+U0301+U0328'
    assert(len(unicode_entry_to_unicode_chars(str)) == 3)
    str = 'U0061+U0301'
    assert(len(unicode_entry_to_unicode_chars(str)) == 2)
    str = 'U0061'
    assert(len(unicode_entry_to_unicode_chars(str)) == 1)

    lines = get_character_translations(None)
    for line in lines:
        print(line)
    

