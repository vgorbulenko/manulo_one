#!/usr/bin/perl -w
use strict;

#
#  https://c9.io/dashboard.html
#



my @arr = qw /a b c d e f/;
my $var1 = 10;



sub func (\@$)  { #prototype -- ref to array and skalar
    my $ref = shift; #first elem @_
    my ($suffix) = @_;  # @_[0]
    
    $_ .= "$suffix" for (@$ref);

}

#$@   scalar and other elem
#\@@  ref_array and other elem


func (@arr, $var1);

print "$_\n" for (@arr);


$a =10;
$ref = \$a;

print $$ref;

###############ANONYM ARRAY

my $ref_array = [10 20 30]; #anonym array fo refrences
print "@$ref_array\n";

func ([a,b,c,d]); ##anonym array 2func

my $ref_hash = { "key1" => "val1", "key2" => {"k1" => "v1"}  }; #anonym hash for ref

					    #вложенная сслыка на вложенный хещ
print "$$ref_hash{key2}\n";
print "${$ref}{key}\n"; #явным образом укзаываем ссылку
print $ref->{key1}; #короче, продвинутая правильная запись с малой стрелкой
print $ref->{key2}->{k1} ."\n";
print $ref->{key2}{k1}. "\n"; #еще рабочий вариант от разработчиков перла )))

#новый элемент во вложеных хеш
$ref->{key2}{k2} = 10;


$ololo =10;

print "${ololo}lalala"; #10lalala

###many mernye array

my @line1 = qw \a,b,c,d\;
my @line2 = qw \e,f,g,h\;

my @matrix = (\@line1, \@line2);

#но так круче

my @new_matrix = (['a','b','c','d'], ['a','s','d','f'], [qw(x y z g)]);

my $matrix_ref = [ [1,2,3,4], [5,6,7,8] ];
print $ref->[1][2] ."\n"; # = 7

for my $i (0..@$ref-1) {
    for my $j (0..@{$ref->[$i]}-1) {
	print "$ref->[$i][$j]   ";
    }
    print "\n";
}


for (@$ref) {
    for .(@$_) {
	print "$_   ";
    }
    print "\n";
}

my $ref->[4][5] = 10;  ##создат норм )))


for (@$ref) {
    for .(@$_) {
	print $_ ? "$_ " : " . "; # if ? then ""  else :""
    }
    print "\n";
}


#####################################next para

sub func {
    $args = shift; #ссылка на анонимных хеш. Проферить тип мона ф-ей ref
    my $X = $args->{X};
    my $Y = $args->{Y};
    my $P = $args->{P};
    #можно заранее в хеше проверить, ести ли такой ключ, или нет
    $X = 10 unless exists $args->{X};
}

func ({'Y' => 20, 'X' => 10, 'P' => 12, 'ololo' => 'alala'}); #анонимный хеш в вызове функции











































