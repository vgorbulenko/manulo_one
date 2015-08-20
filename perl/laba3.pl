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

open (my $file, "<", "/etc/services") || die ("Cann`t open file: $!\n");

my @dupl = ();

ext:while (<$file>) {
#    my $str = chomp($_);
    if ( (length($_)<2 )||(substr ($_,0,1) eq "#") ) { #it`s a magic
	next ext;
    }
    
    my @str = split (" " , $_);
    my $name = $str[0];
    my $prot = 0;
    $prot = $str[1];
    
    @str = split ("/" , $prot);#$str[1] вызвало дикий шквал возражений
    my $port = $str[0];
    $prot = $str[1];
    
    if (($port >= $min_port)&&($port <= $max_port)&&(!($port ~~ @dupl))) {
	print "Port $port -- $name\n";

	push (@dupl,$port);
    }


}



















