#!/usr/bin/perl -w
use strict;

sub longest_word {
    for (@_) {
	my @longest = ("");
	for (@$_) {
	    if ( length($_) == length ($longest[0]) ) {
		push (@longest,$_);
	    }
	    if ( length($_) >  length ($longest[0]) ) {
	        @longest = ();  $longest[0] = $_;  
	    }

	}
	print "--- $_\n" for (@longest);
	print "-----------------------------\n";
    }
}

my @arr1 = qw /dsdff sdesfdsf d3wfbwsdfb sdfb sdf dfb dsf b dswfbwsdfb/;
my @arr2 = qw /werfw w ef re567gew w fe w efw  regwrgew rgr regwr789 eg last_w/;
my @arr3 = qw /sf qsw vgq sv q fbv f bv dfeb degfb 12345 54321/;

longest_word (\@arr1,\@arr2,\@arr3);