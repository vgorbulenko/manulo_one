#!/usr/bin/perl -w
use strict;

$_ = "yabba dabba doo";

if (/y(....) d\1/) { 
    print "It matched same character next to itself!\n";
    print "$`'$&'$'";
    }

exit;


my $str= "<a><htm></be></hu><lya>";

if ( $str=~ m{(</?\w+\b.*?>)}g   )  {
    print "$`'$&'$'\n";
    
    
    
} else {print "no\n";}

print "----".$str."\n";




