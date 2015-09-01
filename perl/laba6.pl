#!/usr/bin/perl -w
use strict;


sub longest_word {
#    my @longest;
#    for (@_) {
#    my $longest_w = "";
#        for (@$_) {
#	    $longest_w = $_ if ( length ($longest_w) < length ($_)  );
#	}
#	push (@longest,$longest_w);
#    }
#    print "--- \'$_\'\n" for (@longest);
    my %longest_w;
    for (@_) {
	my $length = 0;
	for (@$_) {
	    if ( length($_)>$length ) { $length=length($_);  $longest_w[$length] = $_;  }
	}
    print %longest_w;
    }


}



my @arr1 = qw /dsdff sdesfdsf sdfb sdf dfb dsf b last_dswfbwsdfb/;
my @arr2 = qw /werfw w ef w fe w efw  regwrgew rgr eg last_w/;
my @arr3 = qw /sf qsw vgq sv q fbv f bv dfeb last_degfb/;

longest_word (\@arr1,\@arr2,\@arr3);