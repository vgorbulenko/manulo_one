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



############################Вова
print "$&\n" while $text =~ m/d[0-9] if $&; #Класс символов цифры

			    /\D[^0-9]/ #отрицание -- не числа
			    
			    $text =~ /saf|123/  # | альтернатива, ищем либо до, либо после
			    
if ( $text =~ /saaf|f 1|123/) {
    printf ("* prematch: '%s'\n*match: '%s'\npost-match: '%s'\n\n",
	    $` // '<undef>',
	    $& // '<undef>',
	    $' // '<undef>'
    );

}
$text = "ssAffA\n 123123\n";
	    $text =~ /.*123/;  # любые символы до 123
	    /^.*123.*$/s   /^.*123.*$/m   # s включает в . символ переноса строки; m не включает перенос в .  , $ -- будет интерпретирован как конец строки
	    /..../x  #игнорит в регулярке пробелы, переносы строк
	    /
	    12| #find12
	    SdF #find Sdf
	      /x  #пример
	    
$text = "Param1=121212\nParam2=svsdvfs\nParam3=sgsrgfsrgf\n";

$text=~ /^param\d=.*$/mg  #  Param1=121212 ......

$text=~ /^param\d=(.*)$/mg
$1 = то, что попало в скобки   тут 121212 значение Param1

$text=~ /^(param\d)=(.*)$/mg
$1 = Param1
$2 = 121212

$text=~ /^((param\d)=|(.*))$/mg
$1 = Param1=121212
$2 = Param1
$3 = 121212

(?:)($1)($2)($3)    ?: -- не включит скобку в перечень переменных
(?<name1>)  -- значение скобки будет в хеше $+{name1}
$text = "param value param";

$text =~ /(p.*?m)(.*)\1/  \1 укажет регулярке, что нужно подстваить значение из первой группы $1
$1 = param;
$2 = ' value ';



































