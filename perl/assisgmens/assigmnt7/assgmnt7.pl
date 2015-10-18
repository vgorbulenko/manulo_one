#!/usr/bin/perl -w
use strict;
use Books;
use Data::Dumper;

print "\nBOOKS LIBRARY:\n";

inp_file_name:
print "Input DB file name please: ";
chomp (my $file_name = <STDIN>);

if ( Books->set_db_name($file_name) ) {
    print "Error! '$file_name' is not a file!\n";
    goto inp_file_name;
}

sub short_print {
    my $author  = $_[0]->{author}  || "";
    my $title   = $_[0]->{title}   || "";
    my $section = $_[0]->{section} || "";
    my $shelf   = $_[0]->{shelf}   || "";
    my $on_hand = $_[0]->{on_hand} || "";
    my $pos	= $_[0]->{pos}     || "_";

    print "\n$author - \"$title\"\n";
    print "Section: $section POS='$pos'\n";
    print "Placed at $shelf shelf. ";
    unless ($on_hand eq "") {
        print "Now the book took $on_hand\n";
    }
    else {
        print "\n";
    }
}

sub find_books {
    my $b = "$file_name - find > ";
    print $b."Please, enter a conditions to search\n";
    print $b."Title:    "; chomp (my $title   = <STDIN>);
    print $b."Author:   "; chomp (my $author  = <STDIN>);
    print $b."Section:  "; chomp (my $section = <STDIN>);
    print $b."Shelf:    "; chomp (my $shelf   = <STDIN>);
    print $b."On Hands: "; chomp (my $on_hand = <STDIN>);
    if ($title eq "" && $author eq "" && $section eq "" && $shelf eq "" && $on_hand eq "" ) {
	print "Not correct input data!\n";
	return 1;
    }
    my $res = Books->search_books ($title, $author, $section, $shelf, $on_hand);
    print "Find " . scalar(@$res) ." book(s):\n";
    my $count = 0;
    for (@$res) { 
	$count++;
	print $count.". ";
	short_print($_);
    }
}

sub add_book {
    my $b = "$file_name - add > ";
    print $b."Please, complite the following fiels.\n(*) means that tis field is required:\n";
    print $b."Title*:   "; chomp (my $title   = <STDIN>);
    print $b."Author*:  "; chomp (my $author  = <STDIN>);
    print $b."Section*: "; chomp (my $section = <STDIN>);
    print $b."Shelf*:   "; chomp (my $shelf   = <STDIN>);
    print $b."On Hands: "; chomp (my $on_hand = <STDIN>);
    if ($title eq "" || $author eq "" || $section eq "" || $shelf eq "" ) {
	print "Not correct input data!\n";
	return 1;
    }
    Books->add_book ($title, $author, $section, $shelf, $on_hand);
}

sub delete_books {
    my $b = "$file_name - delete > ";
    print $b."Please, enter a conditions to search\n";
    print $b."Title:    "; chomp (my $title   = <STDIN>);
    print $b."Author:   "; chomp (my $author  = <STDIN>);
    print $b."Section:  "; chomp (my $section = <STDIN>);
    print $b."Shelf:    "; chomp (my $shelf   = <STDIN>);
    print $b."On Hands: "; chomp (my $on_hand = <STDIN>);
    my $res = Books->search_books ($title, $author, $section, $shelf, $on_hand);
    print "Find " . scalar(@$res) ." book(s):\n";
    return 0 if (scalar(@$res) == 0);

    my @delete_list;
    for (@$res) {  #формируем список на подтверждение и удаление
	my $item = {};
	$item->{title} = $_->{title};
	$item->{author} = $_->{author};
	$item->{section} = $_->{section};
	$item->{shelf} = $_->{shelf};
	$item->{on_hand} = $_->{on_hand};
	push (@delete_list, $item);
    }
#    print "Delete List complite: ".scalar(@delete_list)." items\n";
    my $numb = 1;
    my $isNoQstn = 0;
    while () {  #ask and do
	last if ( scalar (@delete_list) == 0 );
#	print "+++first_dumper;\n";
#	print Dumper ($delete_list[0]);
	unless ($isNoQstn) {
	    short_print($delete_list[0]);
	    print "$numb: Delete this book? (y/n/ay/an): ";
	    chomp (my $choose = <STDIN>);
	    return 0 if ($choose eq "an");
	    next if ($choose ne "y" && $choose ne "n" && $choose ne "ay");
	    if ($choose eq "ay") {
		#$choose = "y"; #чет глюконуло
		$isNoQstn = 1;
		next;
	    }
	    if ($choose eq "y"){
		my $prey = Books->search_books ( $delete_list[0]->{title},
						 $delete_list[0]->{author},
						 $delete_list[0]->{section},
						 $delete_list[0]->{shelf},
						 $delete_list[0]->{on_hand}
					       );
		$prey = $$prey[0];
		Books->delete_book ($prey->{pos});
	    }
#	    if ($choose eq "n") {   } #хз чо делать ))) просто пропускаем реакцию
	    $numb++;
	}
	else {
#	    print "+-+- First Medium Dumper;\n";
#	    print Dumper (\@delete_list);
	    my $prey = Books->search_books ( "",#$delete_list[0]->{title},
					     $delete_list[0]->{author},
					     $delete_list[0]->{section},
					     $delete_list[0]->{shelf},
					     $delete_list[0]->{on_hand}
					   );
#		print "-+-+ Last Medium dumper;\n";
#		print Dumper ($prey);
		$prey = $$prey[0];
#		print "---LAst Dumper; \n";
#		print Dumper ($prey);
		Books->delete_book ($prey->{pos});
	}

	shift @delete_list;
    }
    
#    short_print($_)  for (@$res);
}



#main cycle
my $command;
my $help = "\n'find' -- find a books\n'add' -- add new book\n'delete' -- delete book(s)\n'exit' -- to leave the library\n\n";
while () {
    print "$file_name > ";
    chomp ($command = <STDIN>);

    last if ( $command eq "exit" );
    if ( $command eq "help" ){
	print $help;
	next;
    }
    if ( $command eq "find") {
	find_books;
	next;
    }
    if ( $command eq "add") {
	add_book;
	next;
    }
    if ( $command eq "delete"){
	delete_books;
	next;
    }
    if ( $command eq "test"){ #Пасхалка )))
	Books->test;
	next;
    }
    
    
    print "Unknow command '$command'. Type 'help' to get help\n";

}


print "Bye\n";

#Books->add_book ("Computer NETs",'Olifer`s', 'manulo', '2', 'Ruslan Ermakov');

#Books->search_books('N|T', 'k');

#Books->delete_book(113);

#Books->test;


