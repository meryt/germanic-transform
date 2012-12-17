#!/usr/bin/python3

import os
import impgermanic

absroot = os.path.dirname(os.path.abspath( __file__ ))

filepath = os.path.join(absroot, '../data/oe_bosworthtoller.txt')
scriptfile = os.path.join(absroot, '../data/oe_bosworthtoller.sql')

impgermanic.build_import_script(filepath, scriptfile)


