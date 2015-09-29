#!/usr/bin/perl -w
use strict;

print "%20s - %-20s\n", $_, $main::{$_} for sort keys %main::; #таблица символов


print "$_\n" for @INC; #массив с путями, с переменных окружения

