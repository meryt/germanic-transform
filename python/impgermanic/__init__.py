#!/usr/bin/python3

import sys
import os.path
from . import utf8izer

def build_import_script(source_filepath, sql_filepath):
    '''Build the import SQL script from the original downloaded datafile, using intermediate steps as necessary'''
    
    # Sanity check
    if not os.path.isfile(source_filepath):
        sys.stdout.write('Data file not found\n')
        return
    
    from . import to_sql
    to_sql.datafile_to_sql(source_filepath, sql_filepath)

