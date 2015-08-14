#!/usr/bin/perl -w

use strict;

print "Please, enter a full path to file: ";
chomp (my $path = <STDIN>);
#chomp ($path);

open (my $fw, "<", "$path") || die "$!\n";

#my $text = "";

my $max = 0;
my $str;

while (<$fw>) {
    my @source = split (" ", $_);
    for (my $i = 0; $i < scalar (@source); $i++) {
	my $lngth = length ($source[$i]);
	if ($lngth > $max) {
	    $max = $lngth;
	    $str = $source[$i];
	}
    
    }
}

print "$str - $max\n";
