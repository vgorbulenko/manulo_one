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

#print "$input_str[-1]\n";

#print search_pos ($inpt, 74518) . "\n";

#print "$_ " for (@input_str);

print "_________________________________________\n";

for (@input_str) {
    my $str = $_;
    my $res_str = "";
    my $lng = length ($str);

    for (my $i=0; $i<$lng; $i++) {
	my $char = substr ($str, 0, 1);
	if ( index ("0123456789", $char)>=0 ) {
	    $res_str .= $char;
	    substr($str,0,1) = "";
        }
	else { last; }
    }
    print $res_str ."   ". $str . "\n";
    print search_pos($inpt,$res_str) . "\n";
}



print "\n";




































