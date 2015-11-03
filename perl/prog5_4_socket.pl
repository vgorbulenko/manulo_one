#!/usr/bin/perl -w
use strict;

###############sockets#######################

#man socket  -- man page of sockets

#############################################


#classical
#server
use Socket;

socket (my $server, PF_INET, SOCK_STREAM, getprotobyname ('tcp') ) or die "$!\n";

setsockopt ($server, SOL_SOCKET, SO_REUSEADDR, 1); 

my $server_port = 9999;
my $addr = sockaddr_in ($server_port, INADDR_ANY); #упакованный адрес  sockaddr_un - unox socket

bind ($server, $addr) or die "Couldn`t bind to port $server_port : $!\n";

listen ($server, SOMAXCONN) or die "Couldn`t listen on port $server_port: $!\n";
		#зависит от ОС, мона свое указать, максимальное кол-во подключений на сокет

while (accept (my $client, $server) ) { #свяжет с клиентским сокетом accept создает новый сокет для того, что бы $server принимал новые подключения
    my $input = <$client>;
    print "'$input'\n";
#    print $client "You have successfully connected\n";
}

close ($server);

#client

use Socket;

my $remote_host = $ARGV[0] || 'localhost';
my $remote_port = $ARGV[1] || 9999;

socket (my $conn, PF_INET, SOCK_STREAM, getprotobyname ('tcp') ) or die "$!\n";

my $in_addr = inet_aton ($remote_host) or die "Inet addr: $!\n";
my $p_addr = sockaddr_in ($remote_port, $in_addr); #упаковываем 

connect ($conn, $p_addr) or die "Coundn`t connect to $remote_host:$remote_port : $!\n";

$|=1; #автосброс, нах не нужен


select ((select($conn), $| = 1)[0]); 
#print $conn "Why don`t you call me anymore?\n";

print $conn "GET / HTTP/1.1\nHost: google.com\n\n";


while (my $res = <$conn>) {
    print $res;
}

#while (1) {
#    my $res = <$conn>;
#    print $res;
#}

close ($conn);







































