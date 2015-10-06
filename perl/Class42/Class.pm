package Class;
#for prog4_2

use strict;
use warning;

our $x = 10;

sub func1 { print "> func1\n"; }
sub func2 { print "> func2\n"; }

sub setx { shift;  $x= shift; } #первый магрументом идеи имя вызвавшего класса ...=ARRAY....
sub getx { return $x; }

#ебошим конструктор, дабы не ипать моски с полями
#пох как назовем
sub new {
    my $class = shift; #первым пришло имя класса, откусили нахрен
    my $self = {};#новый хеш, ссылка на него
    $self->{x} = $_[0] ? $_[0] : int rand(10);
    $self->{y} = $_[1] ? $_[1] : int rand(20);
    bless $self, $class;
    return $self;
}
#сли большая, то мона разбить на несколько логичных подфункций
#деструктор DESTROY   шо его нашел сборщик мусора

#sub set_xy {}


1;