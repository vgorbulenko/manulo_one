package Ball;
use strict;
use warnings;

our ($max_x, $max_y) = (5,3); #initiate module with sub init_square();
my $ifInit = 0;

our @balls;
our @garbage;

my $clrscr = `clear`;

sub init_square ($$) { #max_x  max_y  
    shift;
    ($max_x, $max_y) = @_;
    $ifInit = 1;
    return 1;
}

sub new_garbage {
    shift;
    my $self = {};
    $self->{x} = int rand $max_x;
    $self->{y} = int rand $max_y;
    push (@garbage, $self);
}

sub init_new_ball { 
    my $self = shift;
    $self->{x} = int rand $max_x;
    $self->{y} = int rand $max_y;
    $self->{face} = "☺";
    $self->{type} = "ball";
}


sub new { #init new ball
    return 0 until $ifInit;
    my $class = shift;
    
    print $class."\n";
    sleep 2;
    
    my $self = {};
    init_new_ball($self);
    bless ($self, $class);
    push (@balls, $self);
    return $self;
}


sub print_matrix {
    print $clrscr;
#init clear matrix
    my $matr;
    for my $coord_x (0..$max_x-1) {
	for my $coord_y (0..$max_y-1) {
	    $matr->[$coord_y][$coord_x] = ".";
	}
    }

#$matr->[2-1][7-1] = "☺"; #first Y, second X;
#mapped a balls
    for (@balls) {
	$matr->[$_->{y}-1][$_->{x}-1] = $_->{face};
    }

#mapped a garbage
    for (@garbage) {
        $matr->[$_->{y}-1][$_->{x}-1] = "X";
    }

#print result
    
    for (@$matr) {
	print $_ for (@$_);
	print "\n";
    }

#print "Ball x = $balls[0]->{x} y = $balls[0]->{y}\n";

}

my $check_next_cell = sub {
    my ($self, $next_x, $next_y) = @_;
    return 0 if ( $next_x<1 || $next_y<1 || $next_x>$max_x || $next_y>$max_y );#if square border
    for (@balls) {
	next if $self eq $_;
	return 0 if ( $_->{x}==$next_x && $_->{y}==$next_y ); #if cell not free
    }
    for (@garbage) {
        return 0 if ( $next_x == $_->{x} && $next_y == $_->{y} );
    }
    return 1;
};


sub next_cell {
    my $self = shift;
    my $direct_x = (int rand 3) - 1;
    my $direct_y = (int rand 3) - 1;
    my $next_x = $self->{x} + $direct_x;
    my $next_y = $self->{y} + $direct_y;

    if ( &$check_next_cell($self, $next_x, $next_y) ) {
	$self->{x} = $next_x;
	$self->{y} = $next_y;
    }
}

sub move {
    next_cell($_) for @balls;
}


1;

























