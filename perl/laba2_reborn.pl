#!/usr/bin/perl -w
use strict;

my %hash;

my @input = <>;

for (@input) {  #calculate a symbol rate
    while ($_) { 
	my $char = chop ($_);
	if ($char eq "\n") { $char="new_line"; }
	if (!exists($hash{$char})) {
    	    $hash{$char} = 0;
        }
	$hash{$char} += 1;
    }
}

my @temp = sort {$hash{$a} <=> $hash{$b}} keys (%hash);
my $min = $hash{$temp [0]}; my $min_key = "";
my $max = $hash{$temp [-1]}; my $max_key = "";


foreach (keys (%hash)) {
    my $char = $_; 
    $char = "\\n" if ($_ eq "new_line");
    if ($hash{$_} == $min ) { $min_key .= "'$char' ";  }
    if ($hash{$_} == $max ) { $max_key .= "'$char' ";  }
}

print "max $max_key = $max, min $min_key = $min\n";
