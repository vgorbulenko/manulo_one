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

sub read_host {
#    my $hst;
#    $hst = $_[0];
    
    
    chomp ($_[0]);
    return ($_[0]);
}

sub check {
    my $hst = "";
    my $cnt = "5";
    $hst = $_[0];
    $cnt = $_[1];
    my @result = `ping -c $cnt -i 0.2 -q $hst`;
    my $res_hst; my $res_ip;
    my $tmp = "";    $tmp = $result[0];
    my @str;  @str = split (" ", $tmp);
    ($res_hst, $res_ip) = @str[1,2];

    my $res_max_time;
    $tmp = $result [4];  print $tmp ."\n";  ###GLUKI
    @str = split (" ",$tmp);
    $tmp = $str[3];
    @str = split("/".$tmp);
    $res_max_time = $str[2];
    
    my $res_loss;
    $tmp = $result[3];
    @str = split (" ", $tmp);
    $res_loss = $str[5];
    
    return ($res_hst, $res_ip, $res_max_time, $res_loss);
}

sub print_res {
    my $res_hst = $_[0];  my $res_ip = $_[1];  my $res_max_time = $_[2]; my $res_loss = $_[3];
    my $print_str = localtime() . " : $res_hst $res_ip: max_time = $res_max_time ms; $res_loss of loss\n";

    print $print_str;

}

#print localtime() . "\n";

open (my $file,"<",$input) or die ("Cann`t open $input: $!\n");

#my $host = "";

while (<$file>){
#    $host = $_;
#    chomp ($host);
#    print "HOST = $host    res = $_\n";

#    $host = read_host($_);
    
    my $i = read_host ($_);
    my @y = check ($i,$count);
    print_res(@y);
    


#######    print_res( check( read_host( $_ ) ) );
    

    
    
    
#    my @result = `ping -c $count -i 0.2 -q $host 2>&1`;
#    my $tmp = $result[0];
##    print "TMP = @result\n";
##    if ( substr($tmp,"unknown host") eq "-1"  ) {
#	$tmp = $result[0];
#	my @str = split (" ",$tmp);
#	my $echo = "$str[1]  $str[2]: max_time = ";

#	$tmp = $result[4]; # проверка отсутсвия строки
#	@str = split (" ",$tmp);
#	$tmp = $str[3];
#	@str = split ("/",$tmp);
#	$echo .= "$str[2] ms, ";
#	
#	$tmp = $result [3];
#	@str = split (" ",$tmp);
#	$echo .= "$str[5] of loss;\n";
	



#	if ( $output ne "0" )  { print $out_file $echo;  }
#	print $echo;
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


































