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
#    if ($body =~ m%<([A-Za-z1-9]+)>([\w\s\.]+)</\1>%i) { 
    if ($body =~ m%<([\d\D]+)[ ]{0,}[A-Za-z1-9\"\'\-\_\=\ ]{0,}> #идея дикого класса завлючалась в "любой символ кроме >" для описания возможных уточнений в открывающем теге (<h1 align="center"></h1>). Конструкция [\d\D^>] как то отказалась работать
                    ([\w\s\.]+)
                    </\1>%ix) {
	$body = $` . $';
#	print " --- $2\n";
	$in_tag .= $2." ";
    }
    else { $body = undef; }
}


for ( (split (" ",$in_tag)) ) {
    print "$_\n"  if $_ =~ /(.)\1/g;
}




































