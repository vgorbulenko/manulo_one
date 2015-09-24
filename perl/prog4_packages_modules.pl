#!/usr/bin/perl -w
use strict;

our $var = 100;

print "$_ => $main::{$_}\n" for sort key %::; #выведем хеш с доступными в main переменными

# *main::ARGV
# *main::var

our %var = qw (a 10 b 20);
# *main::var{SCALAR} {HASH} {ARRAY} {REF} {IO} так перл различает одноименные скаляр и хеш

printf "%s\n", *main::var{SCALAR}; #ссылка на скалярную переменную

printf "%s\n",${*main::var{SCALAR}};

printf "%s\n", ${*main::var{HASH}{a}}

#our $var2 = *main::var; #new type_glob
# *var2 = *main::var; #new type_glob   вылетело с ошибкой

our $var2;
*var2 = *main::var;

*var2 = *var;

print $var2; #обратимся к скалярной var
print $var2{a}; #обратимся к хешу

*var2 = ${\*var{SCALAR}}; #как то так обратиться тупо к скаляру

sub var {
    return 15;
}

print *var2{CODE}; #алиас на процедуру

#пакеты
use Sample::First;   #папка Sample файл First.pm (или pl, но не принято) пакет Sample::First

Sample::First::testSub();
print $Sample::First::testSub; #к скаляной переменной обратились

use Sample::Second;
Sample::Second::testSub(); #работает

#############
print "$_ => $MySample::{$_}\n" for sort keys MySample::;

package MySample;

our $var13 =13;
1;


#импортируем блобы

testSub(); #сработает из Sample::First::testSub();

################################
package MySample;
sub undefidedSub {
    return "Hello :)\n";

}

package MySample3;

sub mySub3 {
    print undefidedSub;
}

1;
############

sub importGlog {
    my ($pkg,$var) = @_;
    eval '*MySample3::' . $var . '=*' . $pkg . '::' . $var; #скомпилирует и выполнит на лету

}


importGlob ("MySample", "undefidedSub");



############################

use Data::Dumper;
print Dumper (\@test); #гду то там есть код, который импортировал Dumper в нашу область вилимости

######################

use Sample::Smaple;

testSub;
print $var_smaple;

use Sample::Smaple qw(testSub2); #импортим из @EXPORT_OK

use Sample::Smaple qw(:subs :vars); #импортим из @EXPORT_TAGS


























