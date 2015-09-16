#!/usr/bin/perl -w
use strict;

my $err_str = "Please, use date_format 'MMM dd yyyy' or 'mm-dd-yyyy'\n";

my $date;

if ( $ARGV[0] ) {
    $date = $ARGV[0];
}
else {
    print $err_str;
    exit (1);
}


sub ifBigYear ($) {
    if ( ($_[0]/4)== int($_[0]/4)  ) {
	return  1;
    }
    else {
	return 0; 
    }
}

#my $date = "FeB 28 2016";

if ($date =~ /^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s   #month
            ([0-2]\d|3[0,1])\s   #day
            ([0-2]\d{3})$/xi ) {   #year 

#    printf ("pre = '%s' match = '%s' post = '%s'\n\$1 = '$1'   \$2 = '$2'     \$3 = '$3'\n",$`,$&,$',$1,$2,$3);

    (my $month, my $day, my $year) = (lc($1),$2,$3);

    my $ifBigYear = ifBigYear ($year);

    if ( ( $month ~~ ['jan','mar','may','jul','aug','oct','dec']&&$day<=31 )||
         ( $month ~~ ['arp','jun','sep','nov']&&$day<=30)||
         ( $month eq 'feb'&&$day<=28 && $ifBigYear == 0)|| 
         ( $month eq 'feb'&&$day<=29 && $ifBigYear == 1 ))
    {
        print "OK. Good syntax and date\n";
        exit (0);
    }
    else {
        print "NO. Good syntax, but this is not a valid date!\n";
        print $err_str;
        exit (2);
    }
}

#$date = "02-29-2016";

if ( $date =~ /^(0\d|1[0-2])-([0-2]\d|3[0,1])-(\d{4})$/ ) {
#    print "Pre = '$`'   match = '$&'   post = '$'\n\$1 = '$1'   \$2 = '$2' \$3 = '$3'\n";
    (my $month, my $day, my $year) = ($1, $2, $3);

    my $ifBigYear = ifBigYear($year);

    if ( ($month ~~ [1,3,5,7,8,10,12]&&$day<=31)||
         ($month ~~ [4,6,9,11]&&$day<=30)||
         ($month == 2&&$day <=28&& $ifBigYear == 0 )||
         ($month == 2&&$day <=29&& $ifBigYear == 1) ) 
    {
	print "OK. Good syntax and date\n";
	exit (0);
    }
    else {
        print "NO. Good syntax, but this is not a valid date!\n";
        print $err_str;
        exit (2);
    }

}

#if not valid syntax
print "NO-NO-NO. Bad syntax\n".$err_str;