#!/usr/bin/perl -w
use strict;

#PIPE

#mkfifo pipa --- создать пайпу именованную
#echo "Ololo!!!" > pipa    ждет
#cat pipa   считали, предыдущий процесс отвис

#cat /etc/passwd | tail -n 5 | grep ":" | wc -c

#cat /etc/passwd | tail -n 5 | grep ":" | prog.pl -- муторно каждый раз набирать. нуна автоматом средствами перла
# prog.pl | grep | tail.... -- тоже нуна средствами перла
#похрен на теорию, лабаем

open my $desc, "cat /etc/passwd | head -5 |";  #последняя голая пайпа, признак нашего скрипта

while (<$desk>) {
    print;
}
#в отличии от `cat ....` пайпы не грузят опреативу, все отрабатывается другими процессами и резы на лету передаются нам по кусочкам (тут построчно)

while (<$desk>) {
    print "[prog] $. - $_";
}

#и наоборот
open my $out, "| head -7 | wc -c";
open my $fh, "< etc/passwd";
print $out "xxx $. - $_" while (<$fh>);

#open STDOUT, "| head -7 | wc -c";
#$print "xxx.....";                  пример переопределения существующего дескриптора

open STDOUT, "|-" , "head", "-7" or die "hren: $!\n"; #для всех непонятных случаев   |- мы ожилаем ввод   -| мы передадим в пайпу
				    # тут перл сработал ваще без обращений к bash
#пайпы нужно проверять и на открытии, и на close. При закрытии получим инфу о нормальности выполнения цепочки
#close перехватит коды возврата прог в цепочке
#close обязателен

my $pid = (open OUT, "|-") #or die "Can not fork: $!"; #нежданчик
#форкнет сам себя, неявно. То есть передаст дочернему процессу в его STDIN
#

if ($pid ) { #parent proc
    open my $services, "< /etc/services";
    while (<$services>) {
	print OUT "xxx $. - $_";
    }
    close (OUT);
    wait;#норм сработает, если эти 2 строки грохнуть

}
else { #child
    close (OUT); #не обязательно
    while (<STDIN>) {
        print $_ if unless ( /#/ );
    }
    exit;
}

#wait; мой вариант
print "parent exeting\n";


#обратный вариант. Ребенок считает и передаст через пайпу родаку
#в лабу 15
#... и дпльше

#пайпа посредине
my ($read, $write);
pipe ($read, $write); #женит два дескриптора

my $pid = fork;

if ($pid) { #parent, hi is read
    close ($write); #зыкрываем нахрен не нужный в этом процессе дескриптор
    while (<$read>) {
	print "[parent]: $. - $_";
    }
    close ($read);
}
else { #child
    close ($read); #зыкрываем нахрен не нужный в этом процессе дескриптор

    open my $fh, "< /etc/protocols" or die "Can`t open file: $!\n";
    while (<$fh>) {
	print $write "[child]: $. - $_";
    }
    exit;
}

print "Parent exiting\n";
##########################################











































