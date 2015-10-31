#!/usr/bin/perl -w
use strict;

sub read_host {  #string from file
    chomp ($_[0]);
    return ($_[0]);
}

sub check {  #host, count
    my @result = `ping -c $_[1] -i 0.2 -q $_[0] 2>/dev/null`;

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
    
        return ($res_hst, $res_ip, $res_max_time, $res_loss);
    }
    
    if (!@result) {   #unknown host
        return ("-1", $_[0]); #"-1", "host"
    }
    
    if ($result[4] eq "\n") { #host not response
	my @str = split (" ",$result[0]); 
	return ("0",$str[1],$str[2]); #0, host, (ip)
    }

}


sub print_res {
    my $print_str;
    my $out_file = $_[0];

    if ($_[1] eq "0") { #host not response
#	$print_str = localtime() . " -- Host is not responding: $_[2] $_[3]\n";
	$print_str = " Host is not responding: $_[2] $_[3]\n";
    }

    if ($_[1] eq "-1") {  #no host
#	$print_str = localtime() . " -- No HOST: $_[2]\n";
	$print_str = " No HOST: $_[2]\n";
    }

    if ( ($_[1] ne "0")&&($_[1] ne "-1")  ) { #ping ok
#	$print_str = localtime() . " -- $_[1] $_[2]: max_time = $_[3] ms; $_[4] of loss\n";
	$print_str = " $_[1] $_[2]: max_time = $_[3] ms; $_[4] of loss\n";
    }

    print $print_str;
    if ($out_file ne "-1") { print $out_file $print_str;  }

}

my $error_str = "Use ./prog input_file count [output_file]\n";
if (!$ARGV[0]||!$ARGV[1]) {  print $error_str; exit;}

(my $input, my $count) = @ARGV[0,1];
my $out_file;
if ($ARGV[2]) { open ($out_file,">>",$ARGV[2]) or die ("Error open or create output file: $!/n"); } 
    else { $out_file = "-1"; }

open (my $file,"<",$input) or die ("Cann`t open input file $input: $!\n");

print localtime() . "\n";
if ($out_file ne "-1") { print $out_file localtime()."\n";  }

while (<$file>) {
    next if $_ eq "\n"; #ignore empty line
    print_res ($out_file, check( read_host($_),$count ) );
}


