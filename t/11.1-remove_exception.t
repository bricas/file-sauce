use Test::More;

use strict;
use warnings;

BEGIN {
	eval "use Test::Warn";
	plan skip_all => "Test::Warn required" if $@;
	plan tests => 4;

	use_ok( 'File::SAUCE' );
}

my $sauce = File::SAUCE->new;
isa_ok( $sauce, 'File::SAUCE' );

open( FILE, 't/data/NA-SEVEN.CIA' );
warning_like { $sauce->remove( handle => \*FILE ); } { carped => qr/at/ }, 'Remove (fail - read only [CASE 1])';
close( FILE );

open( FILE, 't/data/spoon.dat' );
warning_like { $sauce->remove( handle => \*FILE ); } { carped => qr/at/ }, 'Remove (fail - read only [CASE 2])';
close( FILE );

