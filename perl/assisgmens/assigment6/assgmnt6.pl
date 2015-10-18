#!/usr/bin/perl -w
use strict;
use Data::Dumper;

#open file
open (my $fh, "<", "perl_wiki.html") or die ("Cann`t open file: $!\n");

#copy <body></body> sections
my $body;
while (<$fh>) {
    chomp ($_);
    $body .= $_ if /<body[\d\D].*?>/ ... /<\/body>/ ;
}

#clear <body></body> tags
$body = $1 if $body =~ m/<body[\d\D].*?>(.*)<\/body>/;

#clear comments
$body =~ s/<!--.+?-->//sg;

#count no_close tags
my %tag;
$tag{$1}++  while( $body =~ /<([a-zA-Z0-9]+).*?>/sg );

#clear all tags
$body =~ s/<.*?>//sg;

#count words
my %word;
$word{$1}++ while ( $body =~ /(\w+)/sg );

#top_10 tags
print "\nTop 10 Tags:\n\n";
my $i = 0;
for (sort {$tag{$b} <=> $tag{$a}} keys (%tag) ) {
    $i++;
    last if ($i > 10);
    print "$i:	 $tag{$_}	$_\n";
}

#top_10 words
print "\nTop 10 Words:\n\n";
$i = 0;
for (sort {$word{$b} <=> $word{$a}} keys (%word) ) {
    $i++;
    last if ($i > 10);
    print "$i:	 $word{$_}	$_\n";
}

#print Dumper(\%tag);
#print Dumper(\%word);




#print $body ."\n";






















