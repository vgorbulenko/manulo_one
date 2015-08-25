#!/usr/bin/perl -w
use strict;

my $input = 0;
my $count = 0;
my $output = 0;

if (!$ARGV[0]) {  print "Use ./prog input_file count [output_file]\n"; exit;}
    else { $input = $ARGV[0]; }

if (!$ARGV[1]) { print "Use ./prog input_file count [outpu_file]\n"; exit; }
    else {  $count = $ARGV[1]; }
    
if (!$ARGV[2]) { $output = 0; } 
    else { $output = $ARGV[2]; }

my $out_file;

if ( $output  ne "0" ) { 
    open ($out_file,">",$output) or die ("Error create output file: $!");
    print $out_file localtime() . "\n";
}

print localtime() . "\n";

open (my $file,"<",$input) or die ("Cann`t open $input: $!\n");

my $host = "";

for (<$file>){
    $host = $_;
    chomp ($host);
#    print "HOST = $host    res = $_\n";
    my @result = `ping -c $count -i 0.2 -q $host 2>&1`;
    my $tmp = $result[0];
#    print "TMP = @result\n";
#    if ( substr($tmp,"unknown host") eq "-1"  ) {
	$tmp = $result[0];
	my @str = split (" ",$tmp);
	my $echo = "$str[1]  $str[2]: max_time = ";

	$tmp = $result[4]; # проверка отсутсвия строки
	@str = split (" ",$tmp);
	$tmp = $str[3];
	@str = split ("/",$tmp);
	$echo .= "$str[2] ms, ";
	
	$tmp = $result [3];
	@str = split (" ",$tmp);
	$echo .= "$str[5] of loss;\n";
	
	if ( $output ne "0" )  { print $out_file $echo;  }
	print $echo;
#    }
#    else {
#	print "Unknown host: $host\n";
#	if ( $output ne "0" )  { print $out_file "Unknown host: $host\n";  }
#    }

    #print ."\n";

}


#my @a = `ping -c 10 -i 0.2 -q google.com`;
#my $counter = 0;
#pring $counter++ . " - $_" for @a;


































