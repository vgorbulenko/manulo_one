#!/usr/bin/perl -w
use strict;

#open (my $fh, "<", "./laba9.html");

my $body;
my $in_body;

while (<>) { chomp($_)&&($body.=$_) if /<body>/ ... /<\/body>/; }

#print $body."\n";

#delete <body></body>
$body = $1 if $body =~ /<body>(.*)<\/body>/;

while ($body) {
    if ($body =~ m%<([A-Za-z1-9]+)>([\w\s\.]+)</\1>%i) { 
#	print "--- $&  ---- $2  ----- \n";
	$body = $`.$';
	print " --- $2\n";
    }
    else { $body = undef; }
}

