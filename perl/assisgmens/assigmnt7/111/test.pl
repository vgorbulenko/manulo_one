#!/usr/bin/perl -w
use strict;


my $test = "123{33[4\n";

$test =~ s/\{/\\{/g;
$test =~ s/\[/\\[/g;

print $test;