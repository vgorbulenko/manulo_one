package Books;
use strict;
use warnings;
use Data::Dumper;

my @books;
my $db_name; my $fh_read; my $fh_uppend;

sub set_db_name {
    shift;
    if ( -f $_[0]) {
	$db_name = $_[0];
	read_db();
	return 0;
    }
    else {
	return 1;
    }
}

sub open_read_db_fh  { 
    open ($fh_read, "<", $db_name) or die ("Error open file '$db_name': $!\n");
}

sub get_read_db_fh {
    return $fh_read;
}

sub close_read_db_fh {
    close ($fh_read);# if ($fh_read);
}

sub read_db {
    $#books = -1;

    open_read_db_fh();# unless $fh_read;
    seek ($fh_read,0,0);
    my $current_str = 0;
    while () {
	last if eof ($fh_read);
        my $str;
	my $self;
        my $ifBegin = 0; 
	while (1) {
	    last if eof ($fh_read);  #проверкку ну конец файла перестраховка
	    $str = <$fh_read>;
	    $current_str++;
	    next if ( $ifBegin==0 &&  $str eq "\n");
	    last if ( $ifBegin==1 &&  $str eq "\n");
	    $ifBegin=1 if $str ne "\n";
	    $self=Books->new;
	    $self->{pos}     = $current_str;
	    $self->{title}   = substr ($str,7,-1);
	    $self->{author}  = substr (<$fh_read>,8,-1);
	    $self->{section} = substr (<$fh_read>,9,-1);
	    $self->{shelf}   = substr (<$fh_read>,7,-1);
	    $self->{on_hand} = substr (<$fh_read>,10,-1);
	    $current_str += 4;
        }
    }
    close_read_db_fh;
    return 0;
}

sub repare_pattern { #Экранируем служебные символы регулярок
    my $patt = $_[0];
    $patt =~ s/\(/\\(/g;  # годный глюк, спасибо ))
    $patt =~ s/\)/\\)/g;
    $patt =~ s/\[/\\[/g;
    $patt =~ s/\]/\\]/g;
    $patt =~ s/\{/\\}/g;
    $patt =~ s/\{/\\}/g;
    return $patt;
}

sub search_books {#title auth section shelf on_hand
    shift;
    my $title_patt   = repare_pattern ($_[0]) || ".*";
    my $author_patt  = repare_pattern ($_[1]) || ".*";
    my $section_patt = repare_pattern ($_[2]) || ".*";
    my $shelf_patt   = repare_pattern ($_[3]) || ".*";
    my $on_hand_patt = repare_pattern ($_[4]) || ".*";
    my $result = [];
    for (@books) {
	my $title   = $_->{title}   || "";
	my $author  = $_->{author}  || "";
	my $section = $_->{section} || "";
	my $shelf   = $_->{shelf}   || "";
	my $on_hand = $_->{on_hand} || "";
	if ( $title   =~ m/$title_patt/   &&
	     $author  =~ m/$author_patt/  &&
	     $section =~ m/$section_patt/ &&
	     $shelf   =~ m/$shelf_patt/   &&
	     $on_hand =~ m/$on_hand_patt/ 
	     ) {
	    #print "$_->{author}: $_->{title}\n";
	    push (@$result, $_);
	}
    }
#    print Dumper($result);
    return $result;
}

sub delete_book { #pos_in_file
    shift;
    open_read_db_fh;
    my $temp_file = "~".$db_name;
    open (my $fh_temp, ">", $temp_file);

    my $pos = $_[0];
    my $str;
    for (1..($pos-1) ) {  #копируем до вхождения удаляемой записи
	$str = <$fh_read>;
	print $fh_temp $str;
    }
    <$fh_read> for (1..7); #пропускаем удаляемые строки
    while (){ #дописываем остаток
	last if eof($fh_read);
	$str = <$fh_read>;
	print $fh_temp $str;
    }
    
    close ($fh_temp);
    close_read_db_fh;
    rename ($temp_file, $db_name); #подмениваем оригинал
    read_db;

}

sub add_book { #title author section shelf on_hand
#TODO Переделать без перезагрузки БД
#определить позицию записи в БД
    shift;

    open ($fh_uppend, ">>", "$db_name");
    print $fh_uppend "\n";
    print $fh_uppend "Title: "   .$_[0]. "\n";
    print $fh_uppend "Author: "  .$_[1]. "\n";
    print $fh_uppend "Section: " .$_[2]. "\n";
    print $fh_uppend "Shelf: "   .$_[3]. "\n";
    print $fh_uppend "On Hands: "  .$_[4]. "\n";
    print $fh_uppend "\n";
    close ($fh_uppend);

    read_db;
}


sub new { #title auth section shelf on_hand
    my $class = $_[0];
    my $self = {};
    $self->{pos} = ''; #start position in DB
    $self->{title} = $_[1]; 
    $self->{author} = $_[2];
    $self->{section} = $_[3];
    $self->{shelf} = $_[4];
    $self->{on_hand} = $_[5];
    bless ($self, $class);
    push (@books, $self);
    return $self;
}



sub test { print Dumper(\@books); }


1;
