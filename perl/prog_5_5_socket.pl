#!/usr/bin/perl -w
use strict; 

#server

use IO::Socket;

my $timeout = 0.5; #вычисляем таймаут на чтение из сокета
my $seconds = int ($timeout);
my $usecond = int (1_000_000 * ( $timeout - $seconds ));
$timeout = pack ( 'l!l!', $seconds, $useconds); #по шаблону приплюсовывает секунды к миллисекундам


my $server_port = 9999;
my $server = IO::Socket::INET->new( LocalPort => $server_port,
			            Type      => SOCK_STREAM,
    				    Reuse     => 1,
                		    Listen => 20,     # or SOMAXCONN
                		    Timeout => 0.5 )#прерывает accept через 0,5 сек
               or die "Couldn't be a tcp server on port $server_port : $@\n";

#while (my $client = $server->accept() ) {
#    print $client "You have connect to the server\n";
#}

my @clients;
my $message;

while (1) {
    (my $client, my $p_addr) = $server->accept();
    $client->setsockopt ( SOL_SOCKET, SO_RCVTIMEO, $timeout) if $client; #заебошим таймаут на чтение из смокета
    push @clients, $client if $client;
    print $client "hello from server" if $client;
    if ($client) {
#        $message .= "$p_addr\n";
        my ($port, $p_ip) = sockaddr_in ($p_addr);
#	$message .= "> $p_ip : $port has entered!\n";
	my $ip = inet_ntoa ($p_ip);
	$message .= "> $ip : $port has entered!\n";

    }
    
    
    

    $message = "";
    my $buff;
    for my $sock (@clients) {
	$buff = <$sock>;
	$message .= ( '[' . split(' ', localtime)[3] . ']' . $buff) if $buff;
    }
    

    for my $sock (@clients) {
	print $sock $message if ($message and $sock->connected);
    }
}


close ($server);