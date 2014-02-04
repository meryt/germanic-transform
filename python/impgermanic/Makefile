PYTHON=/usr/bin/python3

all: oe_bostoll.sqlite

oe_bostoll.sqlite: oe_bostoll.utf8.txt
	$(PYTHON) to_sql.py -t sqlite -f oe_bostoll.utf8.txt -o oe_bostoll.sqlite

oe_bostoll.utf8.txt: mappings.txt
	$(PYTHON) utf8izer.py -f ../../../germanic-lexicon/oe-bosworthtoller/oe_bosworthtoller.txt -o oe_bostoll.utf8.txt -m mappings.txt

mappings.txt:
	$(PYTHON) character_database.py -o mappings.txt ../../../germanic-lexicon/character_database.txt

clean:
	rm mappings.txt oe_bostoll.utf8.txt oe_bostoll.sqlite
