#!/usr/bin/perl -w
use strict;
use Switch;

my $err_mess = "Please, use date_format 'MMM dd yyyy' or 'mm-dd-yyyy'\n";
my $ok_mess = "OK. Good syntax and date\n";
my $no_valid_date_mess = "NO. Good syntax, but this is not a valid date!\n";
my $bad_synt_mess = "NO-NO-NO. Bad syntax\n";

my $date;

if ( $ARGV[0] ) {
    $date = $ARGV[0];
}
else {
    print $err_mess;
    exit (1);
}


sub ifBigYear ($) {
    if ($_[0]%4 == 0) {
	return  1;
    }
    else {
	return 0; 
    }
}

sub validDate ($$$) {

    (my $month, my $day, my $year) = @_;
    my $ifBigYear = ifBigYear($year);

    if ( ($month ~~ [1,3,5,7,8,10,12]&&$day<=31)||
         ($month ~~ [4,6,9,11]&&$day<=30)||
         ($month == 2&&$day <=28&& $ifBigYear == 0 )||
         ($month == 2&&$day <=29&& $ifBigYear == 1) ) 
    {
	print $ok_mess;
	exit (0);
    }
    else {
        print $no_valid_date_mess;
        print $err_mess;
        exit (2);
    }


}

if ($date =~ /^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\   #month
            (0[1-9]|[1,2]\d|3[0,1])\   #day
            ([0-2]\d{3})$/xi ) {   #year 

    my $month = lc($1);
    switch ($month) {
	case 'jan'  { $month = 1 ;}
	case 'feb'  { $month = 2 ;}    
	case 'mar'  { $month = 3 ;}
	case 'apr'  { $month = 4 ;}
	case 'may'  { $month = 5 ;}
	case 'jun'  { $month = 6 ;}
	case 'jul'  { $month = 7 ;}
	case 'aug'  { $month = 8 ;}
	case 'sep'  { $month = 9 ;}    
	case 'oct'  { $month = 10 ;}
	case 'now'  { $month = 11 ;}
	case 'dec'  { $month = 12 ;}
    }

    validDate ($month,$2,$3);
}

elsif ( $date =~ /^(0[1-9]|1[0-2])-(0[1-9]|[1,2]\d|3[0,1])-(\d{4})$/ ) {
     validDate ($1,$2,$3);
}

#if not valid syntax
print $bad_synt_mess . $err_mess;
