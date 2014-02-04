PYTHON=/usr/bin/python3

all: oe_bostoll.sqlite oi_cleasvig.sqlite

oe_bostoll.sql: oe_bostoll.utf8.txt
	$(PYTHON) to_sql.py -t mysql -f oe_bostoll.utf8.txt -o oe_bostoll.mysql

oe_bostoll.sqlite: oe_bostoll.utf8.txt
	$(PYTHON) to_sql.py -t sqlite -f oe_bostoll.utf8.txt -o oe_bostoll.sqlite

oi_cleasvig.sqlite: oi_cleasvig.utf8.txt
	$(PYTHON) to_sql.py -t sqlite -f oi_cleasvig.utf8.txt -o oi_cleasvig.sqlite

oe_bostoll.utf8.txt: mappings.txt
	$(PYTHON) utf8izer.py -f ../../../germanic-lexicon/oe-bosworthtoller/oe_bosworthtoller.txt -o oe_bostoll.utf8.txt -m mappings.txt

oi_cleasvig.utf8.txt: mappings.txt
	$(PYTHON) utf8izer.py -f ../../../germanic-lexicon/oi-cleasbyvigfusson/oi_cleasbyvigfusson.txt -o oi_cleasvig.utf8.txt -m mappings.txt

mappings.txt:
	$(PYTHON) character_database.py -o mappings.txt ../../../germanic-lexicon/character_database.txt

clean:
	rm mappings.txt *.utf8.txt *.sqlite
