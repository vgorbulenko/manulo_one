#!/usr/bin/perl -w
use strict;
use Bur;


#Bur::test();




my ($max_x, $max_y, $count_balls, $count_bur, $count_garbage) = (50, 25, 5, 5, 50);

Bur::init_square ($max_x, $max_y);

#Ball::new() for (1..$count_balls);
Bur::new() for (1..$count_bur);



while (1) {
    Ball::print_matrix();
    Ball::move();
    select (undef, undef, undef, 0.1);
    
}