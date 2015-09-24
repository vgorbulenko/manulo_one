package Sample::Smaple;

use strict;
use warnings;

#объявляем наследника класса, устаревшее
use Exporter;
our @ISA = qw(Exporter); #какой то системный, связан с облостью вилимости
our @EXPORT = qw (testSub $var_smaple); #импортируецца по умалчанию
our @EXPORT_OK = qw (testSub2);#возможен экспорт, но не импортит по умлолчанию
our @EXPORT_TAGS = ('subs' => ['testSub2', 'testSub'], 'vars' => ['$var_smaple']);

#новое
#use base qw (Exporter);
#our @EXPORT = qw (testSub $var_smaple);
#Exporter импортирует 

our $var_smaple = 333;

sub testSub {
    print "Hello from Smaple";
}


sub testSub2 {
    print "Hello from Smaple";
}

1;