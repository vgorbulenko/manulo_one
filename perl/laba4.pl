#!/usr/bin/perl -w
use strict;

my $error_str = "Use ./prog input_file count [output_file]\n";
if (!$ARGV[0]||!$ARGV[1]) {  print $error_str; exit;}

(my $input, my $count) = @ARGV[0,1];
my $out_file;
if ($ARGV[2]) { open ($out_file,">>",$ARGV[2]) or die ("Error open or create output file: $!/n"); } 
    else { $out_file = "-1"; }

open (my $file,"<",$input) or die ("Cann`t open input file $input: $!\n");


while (<$file>) {
    chomp ($_);

#sub check {  #host, count
    my @result = `ping -c $count -i 0.2 -q $_ 2>/dev/null`;
    my $print_str = "";
    if ( (@result == 5)&&($result[4] ne "\n") ) { #ping OK
        my $res_hst; my $res_ip;
        my @str = split (" ", $result[0]);
        ($res_hst, $res_ip) = @str[1,2];

        my $res_max_time;
        @str = split (" ",$result[4]);
        @str = split("/",$str[3]);
        $res_max_time = $str[2];
    
        my $res_loss;
        @str = split (" ", $result[3]);
        $res_loss = $str[5];
    
	$print_str = localtime() . " -- $res_hst $res_ip: max_time = $res_max_time ms; $res_loss of loss\n";
    }
    
    if (!@result) {   #unknown host
	$print_str = localtime() . " -- No HOST: $_\n";
    }
    
    if ( (@result)&& ($result[4] eq "\n") ) { #host not response
	my @str = split (" ",$result[0]); 
	$print_str = localtime() . " -- Host is not responding: $_ $str[2]\n";
    }

    print $print_str;
    if ($out_file ne "-1") { print $out_file $print_str; }
}

#print_res ($out_file, check( read_host($_),$count )) while (<$file>);


