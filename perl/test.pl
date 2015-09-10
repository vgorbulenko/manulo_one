#!/usr/bin/perl -w
use strict;

my %test = $::{aaa}{bbb};

print $_ for (%test);

