#!/usr/bin/perl -w
use strict;
use Fcntl qw(:flock); #импортим буквенные LOCK_SH LOCK_EX ....


#buffers
$| = (@ARGV > 0);#если нет аргументов, то обе строки выведуться одновременно, первая строка зависнет в буффере до его сброса
	    #если есть, то это включит возможность не буфферизированного вывода
	    #$| = 0 -- буферизировать, нет -- не использвать буфер
print "Now you don't see it...";
sleep 2;
print "Now you do";

#межпроцессорное взаимодействие
#работа с файлами

#laba 14

die "Usage: prog.pl file1 [file2 file3 ...]\n" unless (@ARGV > 0);

my ($path, $pid, @forks);

my $res_path = "res.lst";
open my $res, ">", $res_path or die "Can't open res file '$res_path': $!\n";
print $res `date`;

$| = 1;#отключим буфер для прикола, будет больше каши, для STDOUT -- текущего дескриптора
my $old = select $res; # меняем текущий дескриптор по умолчанию
#$ols -- old descriptor
$| = 1; #теперь отменим буферизацию на $res
select $old -- меняемся на старый лескриптор

select (  (select ($res), $|=1)[0] ); #Все вышеперечисленная мудотина с дескрипторами от отмене буфферизации 1 строкой


for (@ARGV) {
    $path = $_; #для каждого дочернего будет своим
    $pid = fork;
    if ($pid) {   #parent
	push @forks, $pid;
    }
    else {  #child
	last;
    }
    
}

unless ($pid) { #for all childs, his jobs
    #lockfile
#    flock $res, 2; #LOCK_EX = 2 

    open my $res_chld, ">>", $res_path or die "Can't open res file '$res_path': $!\n";
    select (  (select ($res), $|=1)[0] ); #Все вышеперечисленная мудотина с дескрипторами от отмене буфферизации 1 строкой

    flock $res, LOCK_EX;

    print "Opening ${path}...\n";
    open my $fh, "<", "$path" or die "Can`t open file '$path': $!\n";
    print $res_chld $path.": ".$_ while (<$fh>);
    exit;

}

waitpid $_,0 for @forks;

print "Done\n"; #for parent






































