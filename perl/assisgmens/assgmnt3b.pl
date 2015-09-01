#!/usr/bin/perl -w
use strict;

#some spaghetti code ))))) 

next_wrld:print "Input a word (Use ]]] to quit): ";
chomp (my $word = <STDIN>);
goto ext if ($word eq "]]]");

open (my $file, "<", "./words.txt") or die "Cann`t open input file: $!\n";

my $count_str = 0;
for (<$file>) {
    $count_str++;
    chomp ($_);
    if ( $word eq $_ ) {
	print "Find \'$word\' in $count_str string\n";
	goto next_wrld;
    }
}

#if no word in dic, goto begin
print "No word \'$word\'  in dictionary :(\n";
goto next_wrld;


ext:print "Bye :)\n";