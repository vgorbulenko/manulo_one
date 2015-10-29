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

my $res_file = "result.lst";
open (my $rfh, "> $res_file") or die ("Can`t open file '$res_file': $!\n");
print $rfh `date`;
print $rfh "Search pattern is $pattern\n";
close $rfh;

my ($pid, $job);
my @childs;

for (@ARGV) {
    $job = $_;
    $pid = fork;
    last unless $pid; #if this is a child, go to job
    push @childs, $pid;
    print "Creare $pid\n";
}

#job for childs
unless ($pid) {
    print ("Start $$ for '$job'\n");

    my $isNotNow = 1; #метка, что не наша очередь
    $SIG{USR1} = sub { $isNotNow = 0; print "$$ - YES - "; }; #по сигналу считаем что уже наша очередь

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

#	push @results, "$n_str: ".$_; #тут заебенить поиск по паттерну, влом, потом, ИДЕЯ ж не терпит)))
	push (@results, $res_str) if ($res_str);
    }
    close $fh;

    #ждемс своей очереди
    sleep 1  while ($isNotNow);

    open ($rfh, ">> $res_file");
    print ($rfh "\n$job:\n");
    print ($rfh $_."\n") for (@results);
    close ($rfh);
    
    print ("Done '$job'\n");
    exit;
}

#jobs for parent
sleep 1; #Костыль. ждем, пока раздупляться дети для приема SIGUSR1

for (@childs) {
    kill USR1 => $_;
    waitpid ($_,0);
}

print "All done\n";
