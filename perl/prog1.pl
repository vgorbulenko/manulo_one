#!/usr/bin/perl

use strict;
use warnings;

my $a = 10;
$a++;
my $b = 132513254;

my @m = ( 1, 2, "aaa", 5.5 );

print a;

for ( my $i = 0; $i < scalar (@m); $i++ ) {    # @#a index last element  scalar (@a)  -- count of elemets
                                            # maybe $i < @a -- use as scalar (@a)
  print $m[$i] . "\n";                                              
}

foreach ( @m ) {
  print $_ . "\n"; #  $_  special var, who print itter znacheniye
}

foreach my $elem ( @m ) {
  print $elem . "\n";  # if change $elem, change massive element
  $elem = "aaa";
}

for my $elem ( @m ) {  #as simple foreach
  print $elem . "\n";

}

print $_ . "\n" for ( @a ); #it work to!))) use for one string code



print @m; #aaaaaaaaaaaaaaaaaaaaa

print $a / $b . "\n";

print "Var a = $a\n"
