#!/usr/bin/perl -w
use strict;

#check`s ARGV
my $error = "Use ./laba14.pl PATTERN file1 [file2 file3 ...]\n";

die ($error) unless (@ARGV);
die ($error) if (-f $ARGV[0]); #если первый аргумент имя файла
die ($error) if ( scalar (@ARGV) <=1 );
for (1 .. scalar(@ARGV)-1 ){ #Если остальные аргументы не имена файлов
    die ($error) unless (-f $ARGV[$_]);
}

my $pattern = shift (@ARGV);

my ($pid, $job);
my @childs;

#creating pipe
my ($pipe_read, $pipe_write);
pipe ($pipe_read, $pipe_write);


for (@ARGV) {
    $job = $_;
    $pid = fork;
    last unless $pid; #if this is a child, go to job
    push @childs, $pid;
    print "Creare $pid\n";
}

#job for childs
unless ($pid) {
    close ($pipe_read); #close read handler. It is only for parent

#    print ("Start $$ for '$job'\n");

    my $isNotNow = 1; #метка, что не наша очередь
    $SIG{USR1} = sub { $isNotNow = 0; }; #по сигналу считаем что уже наша очередь

    open (my $fh, "< $job") or die ("Error open '$job': $!\n");
    #дабы не толпиться в ожидании своей очереди на запись резов, будем их пушать во воременный массив
    my @results;
    my $n_str = 0;
    for (<$fh>) {
	chomp ($_);
	$n_str++;
        my $res_str = "";
	my $isPrintSource = 0;
	while ($_ =~ m/$pattern/g){
	    if ($&){
		unless ($isPrintSource) {
		    $res_str = "  $n_str: $_\n	$&";
		    $isPrintSource = 1;
		}
		else {
		    $res_str .= ", $&";
		}
	    }
	}

	push (@results, $res_str) if ($res_str);
    }
    close $fh;

    #ждемс своей очереди
    sleep 1  while ($isNotNow);

#write to pipe
    print ($pipe_write "$job:\n");
    print ($pipe_write $_."\n") for (@results);
    print ($pipe_write "_ENDNOW\n");#Сообщаем папе что мы усе.
    #без \n строка не отправляется. Запомнить
    close ($pipe_write); #no need now
    
#    print ("[Child $$] Done '$job'\n");
    exit;
}

#jobs for parent
close ($pipe_write); # close 

sleep 1; #Костыль. ждем, пока раздупляться дети для приема SIGUSR1

for (@childs) {
    my $child_pid = $_;
    kill USR1 => $child_pid;
    print "[Parent] Start Listening '$_'...\n";
    while (<$pipe_read>) {
	chomp ($_);
	last if $_ eq "_ENDNOW"; #Ребенок передачу закончил, заканчиваем слушать трубу
	print "[Parent] Catch string: ";
	print "'$_'\n";
    }
    print "[Parent] End listening '$child_pid'\n";
    waitpid ($child_pid,0);
}

close ($pipe_read); #закрываем окончательно пайпу
print "All done\n";
