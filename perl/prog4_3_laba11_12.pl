#!/usr/bin/perl -w
use strict;

use Cell;


Cell->new() for (1..10);

while {
    Cell::move_all();
    Cell::print_matrix();
#    sleep 1;
    select (undef, undef, undef, 0.25);
}