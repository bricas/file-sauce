use Test::More;

use strict;
use warnings;

BEGIN {
	eval "use Test::Exception";
	plan skip_all => "Test::Exception required" if $@;
	plan tests => 4;

	use_ok( 'File::SAUCE' );
}

my $sauce = File::SAUCE->new;
isa_ok( $sauce, 'File::SAUCE' );

throws_ok { $sauce->read( file    => 't/data/dne.txt' ); } qr/No such file or directory/, 'Read (fail - file not found)';
throws_ok { $sauce->read( invalid => 'data' ); } qr/No valid read type/, 'Read (fail - invalid input)';
