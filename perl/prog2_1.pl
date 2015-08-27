#!/usr/bin/perl -w
use strict;

sub func1 {
    print "We are in function\n";


}


&func1(); #canonical request

func1 (); #use too

func1; #and too ))))

sub func2   {
#    @_			#un this array input arguments
    print "$_[0]\n";
}

func2 ("We are in func2!");

sub func3 {
    print "$_\n" for (@_);
}


func3 (qw/10 study network 90/);

my @arr = qw/a b c d e f/;
my $x = 11;

func3 (@arr, qw/10 study network 90/, $x);

sub func4 {
    @_<4 ? return "-1" : print "OK\n"; #if for durdom )))
    print "We are here\n";


#    return $_[-1];  #return last expr result, if no ukazan return
		    # return -- the point out of func
    
}


$x = func4 (@arr);
print $x."\n";


sub func5 {
    return @_[0, -1] if @_ > 1;

}



$x = func5(@arr); # one last element
my ($a, $b) = func5(@arr);
@arr = func5(@arr);




















































