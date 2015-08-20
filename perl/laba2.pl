#!/usr/bin/perl -w
use strict;

my %hash;

sub do_it_good {
    my ($in_text)=@_;
    while ($in_text) {  
        my $char = chop ($in_text);
        if ($char eq "\n") { $char="new_line"; }
        if (!exists($hash{$char})) {
            $hash{$char} = 0;
        }
        $hash{$char} += 1;
#        print "$char - $hash{$char}\n";
    }
}


for (my $i=0; $i < scalar @ARGV; $i++ ) {
    my $in = $ARGV[$i];
    if (-f $in){
	open (my $fw, "<", "$in") || die "Cann`t open file $in: $!\n";
	while (<$fw>) {
	    do_it_good ($_);
	}
    }
    else {
	do_it_good ($in);
    }

}

my $max = 0;
my $max_key = "";
my $min = 0;
my $min_key = "";



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
