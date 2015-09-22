#!/usr/bin/perl -w
use strict;

if (!$ARGV[0]) {
    print "Specify HTML file in input arg\n";
    exit (1);
}

my $body;
my $in_tag;

while (<>) { chomp($_)&&($body.=$_) if /<body[\d\D].*?>/ ... /<\/body>/; }

$body = $1 if $body =~ m/<body[\d\D].*?>(.*)<\/body>/; #delete <body></body>

while ($body) {
    if ($body =~ m%<([A-Za-z1-9]+)>([\w\s\.]+)</\1>%i) { 
	$body = $` . $';
#	print " --- $2\n";
	$in_tag .= $2." ";
    }
    else { $body = undef; }
}

for ( (split (" ",$in_tag)) ) {
    print "$_\n"  if $_ =~ /(.)\1/g;
}




































