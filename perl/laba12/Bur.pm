package Bur;
use base qw(Ball);
use strict;


sub init_new_ball {
    my $self = shift;
    $self->{x} = int rand $Ball::max_x;
    $self->{x} = int rand $Ball::max_y;

    $self->{type} = 'bur';
    $self->{face} = "☼";
    $self->{direct_x} = (int rand 3)-1;
    $self->{direct_y} = (int rand 3)-1;
}


my $check_and_direct = sub {
    my $self = shift;
    my $next_x = $self->{x} + $self->{direct_x};
    my $next_y = $self->{y} + $self->{direct_y};
#garbage
    for (@Ball::garbage) {
	if ( $_->{x}==$next_x && $_->{y}==$next_y ) {
	    $self->{direct_x} *=-1;
	    $self->{direct_y} *=-1;
	}
    }
#other objects
    for (@Ball::balls) {
	if ($_->{x}==$next_x && $_->{y}==$next_y && $_{type} eq "ball"){
	    $self->{direct_x} *= -1;
	    $self->{direct_y} *= -1;
	}
	if ($_->{x}==$next_x && $_->{y}==$next_y && $_{type} eq "bur"){
	    my ($old_dx, $old_dy) = ($self->{direct_x}, $self->{direct_y});
	    $self->{direct_x} = $_->{direct_x};
	    $self->{direct_y} = $_->{direct_y};
	    $_->{direct_x} = $old_dx;
	    $_->{direct_y} = $old_dy;
	}
    }

#square border
#    if ($next_x<0 || $next_y<0 || $next_x>$Ball::max_x || $next_y> $Ball::max_y) 
    if ( $next_x<0 || $next_x>$Ball::max_x ) {
	$self->{direct_x} = (-1)*$self->{direct_x};
    }
    if ( $next_y<0 || $next_y>$Ball::max_y ) {
	$self->{direct_y} = (-1)*$self->{direct_y};
    }

};

sub next_cell {
    my $self = shift;
    if ( $self->{type} eq "ball" ) {
        Ball::next_cell;
    }
    else {
        &$check_and_direct($self);
        $self->{x} += $self->{direct_x};
        $self->{y} += $self->{direct_y};
    }
}


1;



















