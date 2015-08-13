#!/usr/bin/perl -w

use strict;

print "Please, enter a full path to file: ";
my $path = <STDIN>;

chomp ($path);

open (my $fw, "<", "$path") || die "$!\n";

my $text = "";
while (<$fw>) {
    $text .= $_;
}

my @full_text = split (" ", $text);

my $my_max = 0;
my $my_str;

for (my $i = 0; $i < scalar (@full_text); $i++) {
    if (length ($full_text[$i]) > $my_max ) {
          $my_max = length ($full_text[$i]);
          $my_str = $full_text[$i];
        }
}

print "$my_str - $my_max\n";
