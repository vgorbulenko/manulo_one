package Cell;
use strict;
use warnings;


my ($GX,$GY) = (40,20);

my @obj = ();
my $clr = `clear`;

sub new {
    my $class = shift;
    my $self  = {};
    init ($self); 
    bless $self, $class;
    push (@obj, $self);
    return $self;
}

sub init {
    my $self = shift;
    $self->{x} = int rand($GX);
    $self->{y} = int rand($GY);
    $self->{symb} = "0";
}

sub print_matrix {
    my $matrix;
    print $clr;
    for my $y (0..$GY-1) {
	for my $x (0..$GX) {
	    $matrix->[$y][$x] = ".";
	}
    }

    for my $elem (@obj) {
	$matrix->[$elem->{y}][$elem{x}] = $elem->{symb};
    }


    for my $y (0..$GY-1) {
	for my $x (0..$GX) {
	    print $matrix->[$y][$x] = ".";
	}
    print "\n";
    }
}


sub check_free {
    $self = shift;
    my ($new_x,$new_y) = @_;
    for my $obj (@obj) {
	next if $obj == $self;
        return 0 if ($obj->{x} == $new_x && $obj->{y} == $new_y);
        return 0 if ($new_x<1 || $new_x>$GX-1 || $new_y<1 || $new_y > $GY-1);
        return 1;
    }
}

sub move {
    $self = shift;
#    my $dir = int rand 8; #0 -- вверх и дальше по часовой стрелке
    my $dx = (int rand 3)-1;
    my $dy = (int rand 3)-1;
    my $new_x = $self->{x}+$dx;
    my $new_y = $self->{y}+$dy;

    if (check_free ($self, $new_x, $new_y) ) { 
	$self->{x}=$new_x;
	$self->{y}=$new_y;
    }
    
    
}

sub move_all {
    $_->move() for @obj;
}























1;