#!/usr/bin/perl -w
use strict;
use Getopt::Long;

#some mess
my $error_mess = "Incorrect parameters. Use --help to get help\n";
my $help_mess = 
"	<path>
	--path <path>   - Path to root directory;
	--fsize         - Output a size for oll files;
	--dsize		- Output a size for all directory;
	--tree		- Output in tree style;
	--help		- Output help and exit;
	-e 'pattern'	- Find all filenames with pattern;
";

#need incoming flags and var
my  $path = "./";#if no incoming_par, use current working dir (CWD :-) ) to start
our $ifFileSize;
our $ifDirSize;
our $ifTree;
my  $needHelp;
our $pattern;

GetOptions(
    'path=s'	=> \$path,
    'fsize'	=> \$ifFileSize,
    'dsize'	=> \$ifDirSize,
    'tree'	=> \$ifTree,
    'help'	=> \$needHelp,
    'e=s'		=> \$pattern,
) or die $error_mess;

 $path=$ARGV[0] if $ARGV[0]; #если есть неименованный параметр, будем его считать --path

print ($help_mess)&&exit(0) if $needHelp;# print help and exit

sub fileSize ($) {
    my $fs = `du -h $_[0] | awk '{print \$1}'`;  # -s $_[0];
    chomp ($fs);
    return $fs;
}

sub dirSize ($) {
    my $ds =`du --summarize -h $_[0] | awk '{print \$1}'`;
    chomp ($ds);
    return $ds;
}

sub dir_print {
    my ($curr_dir, $deep) = @_;

    opendir (my $dh, $curr_dir);
    my $probe;
    my $long; my $prefix = "";
    while ($probe = readdir ($dh) ) {
	next if $probe eq '.'||$probe eq '..';

	$long = length($probe);
	$prefix = $deep.'---' if $ifTree;

	if (-d $curr_dir.'/'.$probe) {
	    printf ("${prefix}%${long}s",$probe);
	    print ( " (".dirSize($curr_dir.'/'.$probe.'/').")"  ) if $ifDirSize;
	    print "\n";
	    dir_print ($curr_dir.'/'.$probe,$deep."   |");
	}
	else {
	    if ($pattern&&!($probe =~ m/$pattern/))  {
	        next;
	    }
	    else { 
		printf ("${prefix}%${long}s",$probe); #filename
		print ( " (" . fileSize ($curr_dir.'/'.$probe). ")" ) if $ifFileSize;
		print "\n";
	    }
	}
    }

}


#test_var_block
#$path = "./";
#$ifFileSize = 1;
#$ifDirSize = 1;
#$ifTree = 1;

#print root directory and go!
if (-d $path) {
    print $path;
    print ( '('.dirSize($path) .')' ) if $ifDirSize;
    print "\n";
    dir_print ($path,"|");
}
else {
    print "'$path' is not a directory!\n";
    print $error_mess;
    exit (1);
}
