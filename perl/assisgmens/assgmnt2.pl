#!/usr/bin/perl -w
use strict;

open (my $file, "<", "./words.txt") or die "Cann`t open input file: $!\n";
my $count = 0;
for (<$file>) {
    chomp ($_);
    $count++ if ( lc($_) eq lc(reverse($_)) ) 
}

print "Count of polyndroms = $count\n";
