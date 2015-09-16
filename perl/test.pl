#!/usr/bin/perl -w
use strict;
use Data::Dumper;

&myprint ("11 22 33");

sub myprint ()  {
    my $var = shift;
        print $var;
}


