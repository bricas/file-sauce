use Test::More tests => 12;

use File::Slurp;
use strict;
use warnings;

BEGIN {
	use_ok( 'File::SAUCE' );
}

my @files = qw( t/data/bogus.dat t/data/bogus_long.dat );

for my $file ( @files ) {
	my $sauce = File::SAUCE->new;
	isa_ok( $sauce, 'File::SAUCE' );

	# read from file
	$sauce->read( file => $file );
	is( $sauce->has_sauce, 0, 'Has Sauce' );

	# read from handle
	open( FILE, $file );
	$sauce->read( handle => \*FILE );
	is( $sauce->has_sauce, 0, 'Has Sauce' );
	close( FILE );

	# read from string
	my $string = read_file( $file );
	$sauce->read( string => $string );
	is( $sauce->has_sauce, 0, 'Has Sauce' );
}

# valid SAUCE, invalid COMNT
my $sauce = File::SAUCE->new;
isa_ok( $sauce, 'File::SAUCE' );
$sauce->read( file => 't/data/bogus_comnt.dat' );
is( $sauce->has_sauce, 1, 'Has Sauce' );
is( scalar @{ $sauce->comments }, 0, 'Comments' );
