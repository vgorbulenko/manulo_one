#!/usr/bin/perl -w
use strict;

my $x = 10;
my $y = 20;

($x, $y) = ($y, $x);  #menyaem mestami znacheniya peremennyh

my @a = qw/aaa bbb ccc/;  #mozhno tak zadat massiv, vmesto ('aaa', 'bbb', 'ccc')

my @b = ($y, @a);  #massiv @a raskroetsya vnetri massiva @b
		    # (  ) -- spisok
my ($v1, $v2) = ($y, @a, 'qqq'); # $v1 = $y, $v2 = pervy element @a

my ($v1, undef,$v2) = ('aaa', 'bbb', 'ccc'); #1 i 3 element spiska
my ($v1, $v2) = ('111','222','333')[0,2];  #to zhe samoe 
					# [0,2..5];

$x = $a[scalar(@a)-1];  # last element
$x = $a[@a-1];		#tozhe samoe
$x = $a[-1];         #tozhe samoe  [-5..-1]  [-6] ...............

@a = reverse (@a); #v obratnom poryadke

#dobavlnenie elementov massiva

$a[1] = 'xxx'; #izmenili 1 
$a[10] = 'yyy'; #dobavim 10 element

print $_ . "\n" for (@a); #print all element @a

push @a, 'xxx'; #add last element
my $last = pop @a;#print and remove last element


unshift @a, 'yyy'; #add firs element
my $first = shift @a; #print and remove first element

print "$first -- $last \n";


splice @a, 2, 0, @b;    # array, position,count zadeistvovat elenent, chto vstavit, ne trogaya drugih elementov
splice @a, 2, 1, @b[0];    #vstavit vmesto elemeta
splice @a, 2, 3, @b;   #delete three elemets and insert @b
splice @a, 2, 1;  #delete element

push @a, @b;  #@a+@b
splice @a, @a, 0; # tozhe
@a = ($a, @b); #tozhe


###################################################################

%hash = qw /a b c d e f/; # $hash{a}=b, $hash{c}=d;.......
%hash = ('a' => 'b', 'c' => 'd', 'e' => 'f'); #tozhe samoe

print "$hash{a}\n";

$hash {b} = 20; #izmenim znachenie
print "$_ - $hash{$_}\n" for (sort keys %hash);

$hash{new_elem} = "Jupiter"; #add new element
delete $hash{new_elem}; #remove element 

if (exists $hash{new_elem}) { print "Ya, beyba, key is exist"; } #chech exist the key

###delete array

%hash = (); #clear the array

my @arr = /a b c d/;
@arr = (); #clear array -- norm

$arr = undef; #one no init eleme1n  ---- hren
undef array;  #clear array -- norm

###################################################
#Dumper

use Data::Dumper;

print Dumper (@arr); #nice )))))
print Dumper (\@arr); #nice too )))
print Dumper (\%hash); # \ - get address, very  nice )))

#############################################
#sort array

my %heshok = qw (x 1 y 2 z 3);
print Dumper (\%heshok);

print "$_ - $hashok{$_}\n" for (keys %heshok);
print "$_ - $heshok{$_}\n" for (sort keys %heshok); #sort keys
			    # (sort {$a cmp $b} keys %heshok);  tozhe samoe
			    #sort {$b cmp $a} keys ....   revers
			    #cmp for chars, <=> for numbers
print "$_ - $heshok{$_}\n" for (sort {$heshok{$a} cmp $heshok{$b}} keys %heshok); # sort by values



































