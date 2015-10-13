#!/usr/bin/perl -w
use strict;
use Ball;

my ($max_x, $max_y, $count_balls, $count_garbage) = (50, 25, 5, 100);

Ball::init_square ($max_x, $max_y);

Ball::new() for (1..$count_balls); #new ball

Ball::new_garbage() for (1..$count_garbage); #new damaged cells


while (1) {
    Ball::print_matrix();
    Ball::move();
    select (undef, undef, undef, 0.1);
    
}