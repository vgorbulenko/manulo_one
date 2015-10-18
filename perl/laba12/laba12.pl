#!/usr/bin/perl -w
use strict;
use Bur;

my ($max_x, $max_y, $count_balls, $count_bur, $count_garbage) = (50, 25, 5, 5, 50);

Bur->init_square ($max_x, $max_y, $count_garbage);


Ball->new() for (1..$count_balls);
Bur->new() for (1..$count_bur);



while (1) {
    Bur->print_matrix();
    select (undef, undef, undef, 0.2);
    Bur->move();
    
}