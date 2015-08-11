#!/usr/bin/perl -w

use strict;

my @a = ( 1, 5, "aaa", 5.5, 'a', 'b');

my @slice = @a[0, 2..4]; #perechislili element of massive  2..4 = 2, 3, 4

print $_. "\n" for ( @slice );

my %hasho4ek = ("first" => "value1", "second", "ololo");                #assiciativny massive

$hasho4ek{'aaa'} =10; #add new element

print "$hasho4ek {first}";

print "$_\n" for keys (%hesho4ek); #print keys of hash massive

print "$_ => $hasho4ek{$_}\n" for sort keys(%hasho4ek);# with values, sort

                                       # values   -- print values of hash massive
                                       #
                                       #
#if 

my $a = 10;
if ($a == 10) {  # != not equal    ea = ==
	print "OK\n"
}
elsif ($a) {  # if var a exist or not 0
	print "Exist!\n";
}
else {
	print "No\n"
}

unless ($a == 10) { # synonim !=
	print "No\a";
}


my $aa = 1;

while ($aa) {
	print "OK\n"; #bezkonechnu cikl
}

until ($aa) {   #not while, 
	print "OK\n";
}

my $aaa = '-' x 5;  # = -----
print "$aaa\n";    # -----

#input

print "Enter value, please: ";

$input = <STDIN>;
chomp ($input); #otkusit perenos stroki

print "You heave entered this text \"$input\"\n";

my @big_inpup = <STDIN>; #more then one string  Ctrl+d -- end input

print "you big text:\n@big_input"; 


#files

if (open (AAA, "<", "/etc/passwd"))  { print "OK\n"  }; #one way

open (AAA, "<", "/etc/passwd") or die "Error: $! ";#second way ))) whis exit from prog whis system error  \n -- no line where error

my @contents = <AAA>; # $ - first string  @ -- all file  read all file to memory

print @contents; #print file )))

#read file for parts
while (<AAA>) {
	print;
}

#or












































































