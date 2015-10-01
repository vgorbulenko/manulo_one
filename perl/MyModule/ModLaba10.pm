package MyModule::ModLaba10;

use strict;
use warnings;
use Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw (gen min_max_avg print_matrix);


sub gen ($$$) {
    my @matr; 
    (my $x, my $y, my $p) = (@_);
    for (my $i=0; $i<$x; $i++) {
	for (my $j=0; $j<$y; $j++ ) {
	    $matr[$i][$j] = rand($p);
	}
    }
    return \@matr;
}

sub min_max_avg ($) {
    my $ref = shift;
    my $min=$ref->[0][0];
    my $max=$ref->[0][0];
    my $count=0;
    my $avg=0;
    for (@$ref) {
	for (@$_) {
	    $count++;
	    $avg+=$_;
	    if ($_ > $max) { $max = $_; }
	    if ($_ < $min) { $min = $_; }
	}
    }
    $avg = $avg / $count;
    return ($min, $max, $avg);
}

sub print_matrix ($$) {
    my $ref = $_[0];
    my $len_x = length ( scalar (@$ref) )  ;
    my $ii; my $jj;
    my $len = length ( int ($_[1]) ) +1;
    $jj = $ref->[0];
    $jj = scalar (@$jj);  #ширина таблицы
    my $temp=$len+5;
    print " "; printf ("%${len_x}s"," "); print "|";
    for ($ii=1; $ii<=$jj; $ii++) {
	printf ("%${temp}d|",$ii);
    }
    print "\n";
    $ii= ($jj*$temp)+2+2 +$len_x;
    while ($ii) {
	print "-";
	$ii--;
    }
    print "\n";
    $temp=$len+3;
    $ii=1; $jj=1;    
    for (@$ref) {
#	my $len = int $_[1];
	printf ("%${len_x}d | ",$ii);
	$ii++;
	for (@$_) {
	    printf ("%$temp.2f : ",$_);
	}
	print "\n";
    }

}


1;



















