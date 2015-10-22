#!/usr/bin/perl -w
use strict;


my $str = "dsafbs d1`111 kljnmldfblk111;lk;lk;";

while ($str =~ m/111/g) {

 if ($&) {print "$&\n"; }
 
 }

