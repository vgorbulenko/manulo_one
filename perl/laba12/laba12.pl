#!/usr/bin/perl -w
use strict;
use Bur;


Bur::test();




exit;

my ($max_x, $max_y, $count_balls) = (50, 25, 50);

Ball::init_square ($max_x, $max_y);

Ball::new() for (1..$count_balls);


while (1) {
    Ball::print_matrix();
    Ball::move();
    select (undef, undef, undef, 0.1);
    
}