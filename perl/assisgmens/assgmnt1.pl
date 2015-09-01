#!/usr/bin/perl -w
use strict;

my $file;

open ($file, "<", "./words.txt") or die "Cann`t open file: $!\n";
my $count = 0;

for (<$file>) { 
    chomp ($_);
    $count++ if (length($_) >= 15); 
}

print "Count = $count\n";