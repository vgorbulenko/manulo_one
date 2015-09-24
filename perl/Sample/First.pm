package Sample::First;

use strict;
use warnings;

sub testSub {
    print "Hello from me package\n";
}

#для импорта блоба
*main::testSub = *Sample::First::testSub;


our $testSub = 300;

package Sample::Second; #хруновая практика два пакета в одном файле

sub testSub {
    print "Hello from me package 2\n";
}

our $testSub = 500;


1; #завершаем пакет