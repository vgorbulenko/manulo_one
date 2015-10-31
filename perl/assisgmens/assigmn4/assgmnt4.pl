#!/usr/bin/perl -w
use strict;

sub search_pos { #file, pos
    my $file = $_[0];
    my $pos = $_[1];
    seek ($file,0,0);
    my $count = 0;
    my $str;
    for (<$file>){
	$count++;
        if ($count == $pos ) {
    	    $str = $_;
	    last;
	}
    }
    chomp ($str);
    return $str;

}

open (my $inpt, "<", "./assgmnt4_in.txt");
my @input_str = split(" ",<$inpt>);

close ($inpt);

open ($inpt, "<", "./words.txt");

for (@input_str) {
    my $str = $_;
    my $prefix = "";
    my $res_str = "";
    my $postfix = "";
    my $lng = length ($str);
    my $ifDigitBegin = 0;

    for (my $i=0; $i<$lng; $i++) {
	my $char = substr ($str, 0, 1);
	if ( index ("0123456789", $char)>=0 ) {
	    $res_str .= $char;
	    $ifDigitBegin = 1;
        }
	else {
	    if ($ifDigitBegin == 0) { $prefix  .= $char; }
	    else 		    { $postfix .= $char; }
	}
	substr($str,0,1) = "";
    }
    #print $_ . " -------- " . $prefix ." --- ". $res_str . " --- " . $postfix . "\n";
    print $prefix . search_pos($inpt,$res_str) . "$postfix ";
}
print "\n";
