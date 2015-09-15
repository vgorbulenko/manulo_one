#!/usr/bin/perl -w
use strict;

my $date = "Feb 28 2015";

if ($date =~ /^(Jan\s|Feb\s|Mar\s|Apr\s|May\s|Jun\s|Jul\s|Aug\s|Sep\s|Oct\s|Nov\s|Dec\s)#month
              (\d{1,2}\s)#day
              (\d{4})/x)#year
               {
    printf ("pre = '%s' match = '%s' post = '%s'\n\$1 = '$1'   \$2 = '$2'     \$3 = '$3'\n",$`,$&,$',$1,$2,$3);
    (my $month, my $day, my $year) = ($1,$2,$3);
    chop ($month);
    chop ($day);
    if ( ( $month ~~ ['Jan','Mar','May','Jul','Aug','Oct','Dec']&&$day<=31 )||
	 ( $month ~~ ['Arp','Jun','Sep','Nov']&&$day<=30)||
         ( $month eq 'Feb'&&$day<=28)
	)  { print "OK\n";    }
}

$date = "12-31-2031";

if ( $date =~ /(\d{1,2})-(\d{1,2})-(\d{4})/ ) {
    print "Pre = '$`'   match = '$&'   post = '$'\n\$1 = '$1'   \$2 = '$2' \$3 = '$3'\n";
    (my $month, my $day, my $year) = ($1, $2, $3);
    my $ifBigYear;
    if ( ($year/4)== int($year/4)  ) {  $ifBigYear = 1 } else { $ifBigYear = 0; }
    
    
    if ( ($month ~~ [1,3,5,7,8,10,12]&&$day<=31)||
         ($month ~~ [4,6,9,11]&&$day<=30)||
         ($month == 2&&$day <=28 )
    ) { print "OK\n";    }

}