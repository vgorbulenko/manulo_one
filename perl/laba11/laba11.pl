#!/usr/bin/perl -w
use strict;
use ModL11;

my ($max_x, $max_y) = (40 ,30); #max size, min 5x5
my $cells_count = 10;
my $cells_face = "O";
my $cells_delay = 1;
my @cells; #array of cells

for (0..$cells_count-1) { #create our cells
    push (@cells, ModL11->new ($max_x, $max_y) )
}

#for (@cells) {print "$_\n";}
#$cells[0]->new_pos();
#exit;


while (1) {
    #print
    #create matrix
    my $matr;
    for my $coord_x(0..$max_y-1) {
	for my $coord_y (0..$max_x-1) {
	    $matr->[$coord_x][$coord_y]=".";
	}
    }

    #put cells coords in matrix
    for (@cells) {
	$matr->[ $_->{y} ][ $_->{x} ] = $cells_face;
    }
    
    #clr_scr
    print "\033[2J";

    #print matr;
    for (@$matr) {
	for (@$_){
	    print $_; #if ($_) { print $_ } else { print "_" }
	}
	print "\n";
    }
    
    #next_hop )
    for (@cells) { $_->new_pos($max_x,$max_y); }
    sleep ($cells_delay);
}




exit;

my $test = 0;
print "begin\n";
while ($test<10) {
    print "\033[2J";
    
    for (my $x = 0; $x<$max_x; $x++) {
	for (my $y = 0;  $y<$max_y; $y++ ){
	    print $test;
    
    
        }
        print "\n";
    }
    $test++;
    sleep(1);
}


print "end\n";
#my $a = Class->new;