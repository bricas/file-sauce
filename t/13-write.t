use Test::More tests => 168;

use strict;
use warnings;

BEGIN {
    use_ok( 'File::SAUCE' );
}

my $testfile = qw( t/data/write.dat );
my @files    = qw( t/data/NA-SEVEN.CIA t/data/W7-R666.ANS );

for( 1..@files ) {
    my $test  = get_coderef( "write_ok$_" );
    my $file  = $files[ $_ - 1 ];
    my $sauce = File::SAUCE->new( file => $file );
    isa_ok( $sauce, 'File::SAUCE' );

    # write to file
    create_test_file();
    $sauce->write( file => $testfile );
    $test->( File::SAUCE->new( file => $testfile ) );

    # write to handle
    create_test_file();
    open( FILE, ">>$testfile" );
    $sauce->write( handle => \*FILE );
    close( FILE );
    $test->( File::SAUCE->new( file => $testfile ) );

    # write to string
    create_test_file();
    my $string = '';
    $string    = $sauce->write( string => $string );
    $test->( File::SAUCE->new( string => $string ) );

    unlink( $testfile );
}

sub get_coderef {
    my $subname = shift;
    no strict 'refs';
    return *{ $subname }{ CODE };
}

sub create_test_file {
    open( FILE, ">$testfile" );
    close( FILE );
}

sub write_ok1 {
    my $sauce = shift;

    is( $sauce->has_sauce, 1, 'Has Sauce' );
    is( $sauce->sauce_id, 'SAUCE', 'SAUCE Id' );
    is( $sauce->version, '00', 'Version' );
    is( $sauce->title, 'the seventh seal', 'Title' );
    is( $sauce->author, 'napalm', 'Author' );
    is( $sauce->group, 'cia', 'Group' );
    isa_ok( $sauce->date, 'Time::Piece', 'Date' );
    is( $sauce->date->ymd, '1997-10-10', 'Date' );
    is( $sauce->filesize, 40280, 'Filesize' );
    is( $sauce->datatype_id, 1, 'Datatype Id' );
    is( $sauce->datatype, 'Character', 'Datatype' );
    is( $sauce->filetype_id, 1, 'Filetype Id' );
    is( $sauce->filetype, 'ANSi', 'Filetype' );
    is( $sauce->tinfo1, 80, 'Tinfo 1' );
    is( $sauce->tinfo1_name, 'Width', 'Tinfo 1 (name)' );
    is( $sauce->tinfo2, 25, 'Tinfo 2' );
    is( $sauce->tinfo2_name, 'Height', 'Tinfo 2 (name)' );
    is( $sauce->tinfo3, 0, 'Tinfo 3' );
    is( $sauce->tinfo3_name, undef, 'Tinfo 3 (name)' );
    is( $sauce->tinfo4, 0, 'Tinfo 4' );
    is( $sauce->tinfo4_name, undef, 'Tinfo 4 (name)' );
    is( $sauce->comment_id, 'COMNT', 'Comment Id' );
    is( scalar @{ $sauce->comments }, 0, 'Comments (number of)' );
    isa_ok( $sauce->comments, 'ARRAY', 'Comments (ref)' );
    is( $sauce->filler, ' ' x 22, 'Filler' );
    is( $sauce->flags_id, 0, 'Flags' );
    is( $sauce->flags, 'None', 'Flags (name)' );
}

sub write_ok2 {
    my $sauce = shift;

    is( $sauce->has_sauce, 1, 'Has Sauce' );
    is( $sauce->sauce_id, 'SAUCE', 'SAUCE Id' );
    is( $sauce->version, '00', 'Version' );
    is( $sauce->title, 'Route 666', 'Title' );
    is( $sauce->author, 'White Trash', 'Author' );
    is( $sauce->group, 'ACiD Productions', 'Group' );
    isa_ok( $sauce->date, 'Time::Piece', 'Date' );
    is( $sauce->date->ymd, '1997-04-01', 'Date' );
    is( $sauce->filesize, 42990, 'Filesize' );
    is( $sauce->datatype_id, 1, 'Datatype Id' );
    is( $sauce->datatype, 'Character', 'Datatype' );
    is( $sauce->filetype_id, 1, 'Filetype Id' );
    is( $sauce->filetype, 'ANSi', 'Filetype' );
    is( $sauce->tinfo1, 80, 'Tinfo 1' );
    is( $sauce->tinfo1_name, 'Width', 'Tinfo 1 (name)' );
    is( $sauce->tinfo2, 180, 'Tinfo 2' );
    is( $sauce->tinfo2_name, 'Height', 'Tinfo 2 (name)' );
    is( $sauce->tinfo3, 0, 'Tinfo 3' );
    is( $sauce->tinfo3_name, undef, 'Tinfo 3 (name)' );
    is( $sauce->tinfo4, 0, 'Tinfo 4' );
    is( $sauce->tinfo4_name, undef, 'Tinfo 4 (name)' );
    is( $sauce->comment_id, 'COMNT', 'Comment Id' );
    is( scalar @{ $sauce->comments }, 4, 'Comments (number of)' );
    isa_ok( $sauce->comments, 'ARRAY', 'Comments (ref)' );
    is_deeply( $sauce->comments, [
        'To purchase your white trash ansi:  send cash/check to',
        'keith nadolny / 41 loretto drive / cheektowaga, ny / 14225',
        'make checks payable to keith nadolny/us funds only',
        '5 dollars = 100 lines - 10 dollars = 200 lines'

    ], 'Comments (contents)' );
    is( $sauce->filler, ' ' x 22, 'Filler' );
    is( $sauce->flags_id, 0, 'Flags' );
    is( $sauce->flags, 'None', 'Flags (name)' );
}
