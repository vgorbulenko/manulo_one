#!/usr/bin/perl -w
use strict;

sub gen ($$$) {
    my @matr; 
    (my $x, my $y, my $p) = (@_);
    for (my $i=0; $i<$x; $i++) {
	for (my $j=0; $j<$y; $j++ ) {
	    $matr[$i][$j] = rand($p);
	}
    }
    return \@matr;
}

sub min_max_avg ($) {
    my $ref = shift;
    my $min=$ref->[0][0];
    my $max=$ref->[0][0];
    my $count=0;
    my $avg=0;
    for (@$ref) {
	for (@$_) {
	    $count++;
	    $avg+=$_;
	    if ($_ > $max) { $max = $_; }
	    if ($_ < $min) { $min = $_; }
	}
    }
    $avg = $avg / $count;
    return ($min, $max, $avg);
}

sub print_matrix ($$) {
    my $ref = $_[0];
    for (@$ref) {
	for (@$_) {
	    my $len = int $_[1];
	    $len = length ($len);
	    $len+=3;
	    printf ("%$len.2f | ",$_);
	}
	print "\n";
    }

}

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





































