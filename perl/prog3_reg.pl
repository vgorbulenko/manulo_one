#!/usr/bin/perl -w
use strict;

##################регулярки

my $text = "This is the test text we are typing now! :)"; 

print "Matched!\n" if $text =~ m/test/; #m -- текст регулярки  =~ оперятор приявзки
							    #возвращает true/false

print "Matched 2!\n" if $text =~ m/t....g/;   # . - люой символ кроем переноса строки
			    # =~ /t....g/    =~ "t....g"  m{}  m@@ m^^ пох
print "$`---$&---$'\n";   # $& спец переменная с результаттом 
				    # $` - до совпадения  $' после совпадения

		    # !~   обратный =~

print "Matched 2!\n" if $text =~ m/t.{2,5}g/; #от 2 до 5 символов
			    # {,5} -- {0,5}  {2,} -- {2,0}
print "Matched 2!\n" if $text =~ m/t.*g/;
print "Matched 2!\n" if $text =~ m/t.+g/ if $&;

#все совпадения

print "$&\n" while $text =~ m/t.{1,3}t/ if $&; #первое совпадение


print "$&\n" while $text =~ m/t.{1,3}t/g if $&; #все совпадения (по жадному алгоритму, не факт) , g -- global

print "$&\n" while $text =~ m/t[a-zA-Z]{1,3}t/g if $&; #искать тока буквы


print "$&\n" while $text =~ m/t[A-z]{1,3}t/g if $&; #тоже работает

print "$&\n" while $text =~ m/t[a-z]{1,3}t/ig if $&; # i- ignore case

print "$&\n" while $text =~ m/t[A-Za-z0-9_]{1,3}t/g if $&; #слово описали
print "$&\n" while $text =~ m/t\w{1,3}t/g if $&; # \w --заменяет предыдущую порнуху

print "$&\n" while $text =~ m/t[\w\-]{1,3}t/g if $&; #сделали свой класс на основе существующего

print "$&\n" while $text =~ m/t[^\-]{1,3}t/g if $&; #все символы кроме -



























