#!/usr/bin/perl -w
use strict;

my $error_str = "Please, specify the port or range\nAs simple, 1245  or 1245 1258\nNote: Port is natural number from 1 to 65535\nThanks!\n";

if ( !$ARGV[0] ) {   #Check if exist at least one argument
    print $error_str;
    exit 1;
}
my $min_port = $ARGV[0];
my $max_port = $min_port;

if ($ARGV[1]) {
    $max_port = $ARGV[1];
}

local $^W = 0;
if ( ( ($min_port == 0 && $min_port ne '0') || $min_port < 0 || $min_port > 65535)||   #check if specified arguments is numeric
     ( ($max_port == 0 && $max_port ne '0' )|| $max_port < 0 || $max_port > 65535) ) { #and greater tnen zero, and less or equal to 65535
    print $error_str;
    exit (1);
}


if ($min_port > $max_port) {  ($min_port, $max_port) = ($max_port, $min_port); }

open (my $file, "<", "/etc/services") || die ("Cann`t open file: $!\n");

my @dupl = ();

ext:while (<$file>) {
#    my $str = chomp($_);
    if ( (length($_)<2 )||(substr ($_,0,1) eq "#") ) { #it`s a magic
	next ext;
    }
    
    my @str = split (" " , $_);
    my $name = $str[0];
#    my $prot = 0;
    my $prot = $str[1];
    
    @str = split ("/" , $prot);#$str[1] вызвало дикий шквал возражений
    my $port = $str[0];
#    $prot = $str[1];
    
    if (($port >= $min_port)&&($port <= $max_port)&&(!($port ~~ @dupl))) {
	print "Port $port -- $name\n";

	push (@dupl,$port);
    }


}



















