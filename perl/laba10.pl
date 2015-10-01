#!/usr/bin/perl -w
use strict;
use MyModule::ModLaba10;


my $err_str = "Please, use ./prog <X arr> <Y arr> <max_random>\n";

if (! exists($ARGV[2])) {
    print $err_str; 
    exit;
}

(my $x, my $y, my $p) = (@ARGV);

my $matrix = gen ($x, $y, $p);
(my $min, my $max, my $avg) = min_max_avg ($matrix);
print_matrix ($matrix,$max);

print "MIN = $min, MAX = $max, AVG = $avg\n";

