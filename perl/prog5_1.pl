#!/usr/bin/perl -w
use strict;

#signals
our @a=10;

{
    local $a = 20; #только с глобальными переменными сработает
    local $SIG{INT} = { print "$a \n" };  #временное переопределение тольк для текущего блока и подблоков
    
    print $a."\n";

}
print $a."\n"; # a = 10

my $pid = $$;
my @pids;

kill 10 => $pid; #посылаем сигнал
kill USR1 => $pid;
kill HUP =>@pids;