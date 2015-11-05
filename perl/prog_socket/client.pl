#!/usr/bin/perl -w
use strict;

#создадим сокет
use IO::Socket;

my $remote_host = $ARGV[0] || '192.168.144.10';
my $remote_port = $ARGV[1] || 9999;



my $socket = IO::Socket::INET->new(PeerAddr => $remote_host,
                                   PeerPort => $remote_port,
                                   Proto    => "tcp", #может угадать
                                   Type     => SOCK_STREAM )
                or die "Couldn't connect to $remote_host:$remote_port : $@\n";


#форкнемся

select ((select($socket), $|=1)[0] ); #откючим буферизацию, бо глючит сука
my $pid = fork;


#print $socket "Hello )))";

#нуна проверять, жив ли сокет, не здох ли сервак
#родитель ждет сокет и пишет на STDOUT
if ($pid) { #parent
    my $from_srv;
    while (1) {
        $from_srv = <$socket>;
	print $from_srv;
    }
}
#ребенок ждет ввода с STDIN и пишет в сокет
else { #child
    my $from_user;
    while (1) {
	$from_user = <STDIN>;
	print $socket $from_user;
    }
}



close $socket;





