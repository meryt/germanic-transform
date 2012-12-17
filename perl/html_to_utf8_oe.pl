#!/usr/bin/perl

# ****************************************************************************
# html_to_utf8_oe.pl
# 
# Converts Old English HTML documents with macrons, ae ligatures, etc., to 
# unicode format.
#
# Reads from STDIN and writes to STDOUT
#
# Written for and tested with Bosworth-Toller OE dictionary.
# http://lexicon.ff.cuni.cz/txt/oe_bosworthtoller.txt
# ****************************************************************************

use strict;
use warnings;
use GermanicCharConversions;

# Enable this section if you want to stop on the first warning.
# However this does stop on BosToll, possibly due to too many
# matches in a single line?  If that line is broken up it works.
#use diagnostics;
#BEGIN { $SIG{'__WARN__'} = sub { die $_[0] } ; }

# tell Perl output is a utf8 I/O stream
binmode STDOUT, ":utf8";

for my $line (<STDIN>) {
	if ($line ne "\n") {
		# Replace outright errors
		$line =~ s/&eth&aelig;/\x{00F0}\x{00E6}/g;
		$line =~ s/&oacute /\x{00F3} /g;
		$line =~ s/&ethe hys hand/\x{00F0}e hys hand/g;

		$line = GermanicCharConversions::to_utf8($line);
	
		# Execute substitutions for items that are not
		# in the character chart as of this writing
		$line =~ s/&alpha-tonos;/\x{03AC}/g;
		$line =~ s/&epsilon-tonos;/\x{03AD}/g;
		$line =~ s/&eta-tonos;/\x{03AE}/g;
		$line =~ s/&iota-tonos;/\x{03AF}/g;
		$line =~ s/&omicron-tonos;/\x{03CC}/g;
		$line =~ s/&upsilon-tonos;/\x{03CD}/g;
		$line =~ s/&omega-tonos;/\x{03CE}/g;
		$line =~ s/&oactute;/\x{00F3}/g;
		$line =~ s/&oacite;/\x{00F3}/g;
		$line =~ s/&iactute;/\x{00ED}/g;
		$line =~ s/&aleig-acute;/\x{01FD}/g;
		$line =~ s/&dash-uncertain;/\x{2014}?/g; # em-dash plus question
		$line =~ s/&thorn-bar;/\x{00FE}?/g; # just use reg. thorn
		$line =~ s/&k-bar;/k/g; # just use reg. k
		$line =~ s/&THORN-bar;/\x{00DE}?/g; # just use reg. thorn
		$line =~ s/&thron;/\x{00FE}/g;
		$line =~ s/&ealig;/\x{00E6}/g;  # I assume this is an error
		$line =~ s/&alig;/\x{00E6}/g;  # I assume this is an error
		$line =~ s/&a-super;/<sup>a<\/sup>/g;
		$line =~ s/&e-super;/<sup>e<\/sup>/g;
		$line =~ s/&o-super;/<sup>o<\/sup>/g;
		$line =~ s/&e-sub;/<sub>e<\/sub>/g;
		$line =~ s/&t-super;/<sup>t<\/sup>/g;
		$line =~ s/&m-super;/<sup>m<\/sup>/g;

		$line =~ s/&i-longg/\x{012B}/g;
		
		$line =~ s/&oacute/\x{00F3}/g;
		$line =~ s/&aelig-long/\x{01E3}/g;
		$line =~ s/&aelig/\x{00E6}/g;
		$line =~ s/aelig;/\x{00E6}/g;
		$line =~ s/&eth/\x{00F0}/g;
	}



	print $line;
}


