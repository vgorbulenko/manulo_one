package ModL11;
#for laba 11

use strict;
use warnings;
#use Exporter;

#our @ISA = qw (Exporter);
#our @EXPORT = qw (new_pos new); 

sub new_pos {  #max_x  max_y
    my $self = shift;
    my ($max_x, $max_y) = @_;
    $self->{direct_x}=0 if $self->{x} >= $self->{max_x}-1; #нестрогие неравенства на всякий случай :)
    $self->{direct_x}=1 if $self->{x} <= 0;
    $self->{direct_y}=0 if $self->{y} >= $self->{max_y}-1;
    $self->{direct_y}=1 if $self->{y} <=0;
#move
    if ( $self->{direct_x} ) { $self->{x}++; }  else { $self->{x}--; }
    if ( $self->{direct_y} ) { $self->{y}++; }  else { $self->{y}--; }
#if out of range
    if ( $self->{x} > $max_x ) { $self->{x}=$max_x; $self->{direct_x}=0; }
    if ( $self->{y} > $max_y ) { $self->{y}=$max_y; $self->{direct_y}=0; }
    return 1;
}


sub new {
    my $class = shift; #первым пришло имя класса
    my $self = {};#новый хеш, ссылка на него
    $self->{max_x} = $_[0] ? $_[0] : 40;
    $self->{max_y} = $_[1] ? $_[1] : 20;
    $self->{x} = $_[2] ? $_[2] : int rand($self->{max_x}-1);
    $self->{y} = $_[3] ? $_[3] : int rand($self->{max_y}-1);
    $self->{direct_x} = $_[4] ? $_[4] : (int rand(3)) -1); 
    $self->{direct_y} = $_[5] ? $_[5] : (int rand(3)) -1);
    bless $self, $class;
    return $self;
}

1;