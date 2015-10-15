#!/usr/bin/perl -w
use strict;

print ">> Parent start <</n/n";


#system "ls -al /; sleep 10;";
system "sleep 10 &" #заебенит в бекграун. Процесс будет дочерним у инита


print system "ls -l \ "; #запрустит sh , который запустит уже команду

my $res =  `ls -a \`; # `` захватывают STDOUT и выдают его как результат

$res = qx[la -l]; #аналог ``

system 'sleep', '10'; #процесс будет напрямую пpивязан к программе, без вызова посредника sh


my $seconds = '1; ls/;';#возможность иньекции )))
system "sleep $seconds"; #хероватый подход, небезопасный. Нужна защита от подстаовки (иньекции)


$seconds = '1';
exec "sleep $seconds; echo 'Ku!)))' "; #warnings не понравиться. он посчитает, что нужен system()
# и сука будет прав, ехес заместит наш процесс

#РУЦИИИИ )))))))

fork; #создаст новый клон-процесс, при чем его выполнение будет с того места, где форкнули в родителе
#вернет PID нового процесса родителю, 0 -- потомку. Так выянсним, ху из ху
#undef если все плохо

my $pid = fork;

if ( !defined $pid) {
    print 'no (((\n';
    exit;
}
elsif ($pid ) {
    print "I am a parent\n";
}
else {
    print "I am a child\n";
    exit 0;
}

wait; #заставит родителя подождать малыша 
#waitpid тоже вариант конкретного PID)


my @pids;
my $pid = 0;

for (1..10) {
    $pid = fork;
    last unless $pid; #если ребенок, съебываем нахрен из for
    push @pids, $pid;
}


unless ($pid) {
    sleep int rand 5;
    print "I`m your". @pids ."-th child, beach!\n";
    exit 0;
}

#wait; #подождет первый отстрелившийся процесс и склеит ласты

waitpid $_,0 for @pids; #ждет конкретный ПИД и тока потом отваливается
#в данном случае хватает подряд пиды и ждет тоды, когда пид еще существует




print ">> Parent end <</n/n";








































