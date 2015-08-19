#!/usr/bin/perl -w
use strict;

if (!$ARGV[0]) { 
    print "You must specify the port!\n";
    exit;
}
my $min_port = $ARGV[0];
my $max_port = $min_port;

if ($ARGV[1]) {
    $max_port = $ARGV[1];
}

if ($min_port > $max_port) {
    ($min_port, $max_port) = ($max_port, $min_port);
}

open ($file, "<", "/etc/serveces");

while (<$file>) {
    


}