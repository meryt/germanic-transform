#!/usr/bin/perl

use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

# Read dict line-by-line from stdin

my $line = <STDIN>;

# read until after closing introduction
while ($line !~ /^<\/INTRODUCTION>$/) {
	$line = <STDIN>;
}

my $cur_page = '';
my $cur_header;
my $cur_entry = '';
my $cur_entry_page = '';
my $cur_entry_text = '';

LINE: while ($line = <STDIN>) {

	next LINE if $line =~ /^$/;

	# Look for new page
	if ($line =~ /<PAGE NUM="([bd][0-9]{4})/) {
		$cur_page = $1;
	}
	elsif ($line =~ /<HEADER>(.*)<\/HEADER>/) {
		$cur_header = $1;
		$cur_header = sqlescape($cur_header);
		print "INSERT INTO pages (id, header) VALUES ('$cur_page', '$cur_header');\n";
	}
	elsif ($line =~ /^\<B\>([^,.]*?),*\<\/B\>/) {
		# write current entry
		if ('' ne $cur_entry) {
			writeCurrentEntry($cur_entry_page, $cur_entry, $cur_entry_text);
			$cur_entry_text = '';
		}
		# start a new entry
		$cur_entry = $1;
		$cur_entry_text = $cur_entry_text . ' ' . $line;
		$cur_entry_page = $cur_page;
	}
	elsif ('' ne $cur_entry) {
		$cur_entry_text = $cur_entry_text . ' ' . $line;
	}
	elsif ('' eq $cur_entry && $line =~ /^([^ \\.,]+). /) {
		# start a new entry
		$cur_entry = $1;
		$cur_entry_text = $cur_entry_text . ' ' . $line;
		$cur_entry_page = $cur_page;	
	}
}

if ('' ne $cur_entry) {
	writeCurrentEntry($cur_entry_page, $cur_entry, $cur_entry_text);
}

exit;


sub sqlescape {
	my $str = shift;

	$str =~ s/'/''/g;

	return $str;
}

sub writeCurrentEntry {
	my ($cur_entry_page, $cur_entry, $cur_entry_text) = @_;
	
	$cur_entry = sqlescape($cur_entry);
	$cur_entry_text = sqlescape($cur_entry_text);
	print "INSERT INTO entries (page_id, headword, entry) VALUES ('$cur_entry_page', '$cur_entry', '$cur_entry_text');\n";	
}

