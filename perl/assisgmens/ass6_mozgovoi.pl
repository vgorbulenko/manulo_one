#!/usr/bin/perl
use strict;
use warnings;


open ( my $fh, "<", 'perl_wiki.html') or die "$!\n";

my $body;
my %words;
my %tags;

while (<$fh>) {
    $body .= $_ if /<body.*?>/ .. /<\/body.*?>/;
}

# Get comments tags
while ($body =~ /(<!--.+?-->)/sg) {
     $tags{$1}++;
}

# Get tags
$body =~ s/<!--.+?-->//sg;
while ($body =~ /(<(\w+).*?>)/sg) {
     $tags{$1}++;
}

# Clear scripts & tags
$body =~ s/<script.*?<\/script>//sg;
$body =~ s/<.*?>//sg;

# Get words
while ($body =~ /(\w+)/sg) {
     $words{$1}++;
}

my $count;

print "Words:\n";
for (sort { $words{$b} <=> $words{$a} } keys %words) {
     $count++;
     print $count.". ".$_ . " - " . $words{$_} . "\n";
     last if ($count == 10);
}

$count = 0;

print "Tags:\n";
for (sort { $tags{$b} <=> $tags{$a} } keys %tags) {
     $count++;
     print $count.". ".$_ . " - " . $tags{$_} . "\n";
     last if ($count == 10);
}
