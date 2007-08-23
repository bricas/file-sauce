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

dies_ok { $sauce->read( file    => 't/data/dne.txt' ); } 'Read (fail - file not found)';
dies_ok { $sauce->read( invalid => 'data' ); } 'Read (fail - invalid input)';
