#!/usr/bin/perl -w
use strict;

my %hash;
;

for (my $i=0; $i < scalar @ARGV; $i++ ) {
    my $in = $ARGV[$i];
    if (-f $in){
	open (my $fw, "<", "$in") || die "Cann`t open file $in: $!\n";
	while (<$fw>) {
	    $in = $_;
	    while ($in) {  #сделать процедуру, нефик по 2 раза одинаковый код повторять
		my $char = chop ($in); #добавить проверку \n и его проебразование 
		if (!exists($hash{$char})) {
		    $hash{$char} = 0;
		}
		$hash{$char} += 1;
		print "$char - $hash{$char}\n";
	    }
	}
    }
    else {
        while ($in) {
		my $char = chop ($in);
	    if ( !exists($hash{$char}) ) {
	        $hash{$char} = 0;
            }
	    $hash{$char} += 1;
        print "$char - $hash{$char}\n";
	}
    }

}

my $max = 0;
my $max_key = "";
my $min = 0;
my $min_key = "";

#outerloop:foreach my $val (sort values %hash) {
#    $min = $val;
#    $min_key = key %hash;
#    last outerloop;        #    break;
#}

ext:for my $key ( sort { $hash{$b} <=> $hash{$a} } keys(%hash) ) {
#    print $key, ' => ', $hash{$val}, "\n";
    $max_key = $key;
    $max = $hash{$key};
    last ext;
}

ext:for my $key ( sort { $hash{$a} <=> $hash{$b} } keys(%hash) ) {
#    print $key, ' => ', $hash{$val}, "\n";
    $min_key = $key;
    $min = $hash{$key};
    last ext;
}


#my $str = sort {$a <=> $b} values %hash;

print "max '$max_key' = $max, min '$min_key' = $min\n";


print "end\n";

