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

sub print_matrix ($$$$) {   # ref  max  x  y
    my ($ref,$length,$size_x,$size_y) = @_;
    $length       = length ( int ( $_[1]))+3; #ширина основных колонок
    my $length_first = length ($size_x); #ширина первой колонки
    my $ii; #разнорабочая переменная

#1 строка -- заголовок
    print "\n";
    printf ("%${length_first}s |"," ");
    for ($ii=1; $ii<=$size_y; $ii++) {
	printf (" %${length}d |",$ii);
    }
    print "\n";
#2 строка -- разделитель
    $ii= ($length_first+2) + ($length+3)*$size_y;   ; #прикинем нужное количество символов

    while ($ii) {
	print "-";
	$ii--;
    }
    print "\n";
#основная таблица + нумерация строк
    $ii = 1; #номер строки здесь  
    for (@$ref) {
	printf ("%${length_first}d | ",$ii);
	$ii++;
	for (@$_) {
	    printf ("%${length}.2f : ",$_);
	}
	print "\n";
    }
    print "\n";
}

1;



















