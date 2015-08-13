#!/usr/bin/perl -w
#
use strict;

my $path = $ARGV[0] || "/etc/passwd";
my $separator = $ARGV[1] || ":";


open (my $fh, "<", "$path") or die "$!\n"; # < read,   > write,  >>append, +<read and write no create,  +>> aan no trunc,
open (my $fh_w, ">", "./res.txt") or die "$!\n";

while (<$fh>) {   #sdfvd:sdvfsdg:sdgsg
   # @line = split ":", $_;
    my $user = (split "$separator", $_)[0]; #first element ))))   (a, b, c, d)[0] = a
#    print "$user\n";
    print $fh_w "$user\n";   # write to descriptor (in file)
}

while (<>) {  # first letter from STDIN
    print +(split ('' , $_))[0] . " ";  #+ as repare )

}

