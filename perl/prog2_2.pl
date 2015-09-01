#!/usr/bin/perl -w
use strict;

use Data::Dumper;

my @arr = qw/a b c d e f/;

my %hash = @arr; # a - b, c -d, ...

@arr=%hash; # a b c d e f

print Dumper (\%hash);

%hash = reverse %hash; #поменяeт местами ключи и значения. Ключ должен быть уникальным!!!

############FUNC  SUB    UIIII ))))

my @arr = qw/a b c d e f/;

sub func {
    $_ .= 'x' for @_; #работает с исходным массивом!!!
    my @local_arr = @_; #что бы не изменить исходные данные

}

func (@arr);  #ax bx cx dc..... :\    работает падло не с копией, а напрямую с переданным массивом или переменной

for my $itter (@arr) {
    $itter .= 'y';   #axy bxy cxy....
}

print Dumper (\@arr);

##################замыкание

#объявляем неименованый блок
{
    my $itterator = 0;
    sub func2 {
	$itterator++;
	print $itterator . "\n";
    }
}


func2; #$itterator = 1
func2; #$itterator = 2
func2; #$itterator = 3;

###############################передача массивов в функцию

my @arr = qw /x y z/;
my @arr2 = qw /a b c/;

sub second_elem {
    for (@_) { 
	print $_->[1] . "\n"; #выыедет второй элемент иж каждого переданного массива
    }


}

second_elem (\@arr, \@arr2);    #указатели на массивы

##########################
my @arr = qw /x y z/;

my $ref = \@arr;

my $scalar = 10;
my $ref2 = \$scalar;

print ref ($ref2); #вернет тип переменной по ссылке SCALAR   вместо SCALAR(0x23574983)



































