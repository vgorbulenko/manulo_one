#!/usr/bin/perl -w
use strict;

my $own_pid = $$; #для запоминания 
print "My PID = $own_pid\n";

$SIG{USR1} = \&my_usr1;
$SIG{USR2} = \&my_usr2;
$SIG{INT} = sub { kill (10, $own_pid); exit; }; 

my @last_10_sec_proc;
sub my_usr1 {
#    print "Catch SIGUSR1\n";
    my $all = 0;
    $all += $_ for (@last_10_sec_proc);
    $all /= scalar (@last_10_sec_proc) if (scalar (@last_10_sec_proc) > 0);
    print "Average number of process last 10 sec: $all\n";
}

sub my_usr2 {
#    print "Catch SIGUSR2\n";
#    print `cat /proc/meminfo | head -n 2 | tail -n 1`;
    chomp (my $free   =  `cat /proc/meminfo | head -n 2 | tail -n 1 | awk {'print \$2;'}`);
    chomp (my $buffer   = `cat /proc/meminfo | head -n 3 | tail -n 1 | awk {'print \$2;'}`);
    chomp (my $cached   = `cat /proc/meminfo | head -n 4 | tail -n 1 | awk {'print \$2;'}`);
    $free = $free + $buffer + $cached;
    print "Free mem = $free kb\n";

}



while () {
    my $count_proc = `ps aux | wc -l` - 1; #1 строка легенды
    push (@last_10_sec_proc, $count_proc);
    shift @last_10_sec_proc if ( scalar (@last_10_sec_proc) >= 10 );
    sleep 1;
}