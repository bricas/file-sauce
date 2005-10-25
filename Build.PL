use strict;

use Module::Build;

my $build = Module::Build->new(
	module_name        => 'File::SAUCE',
	dist_author        => 'Brian Cassidy <bricas@cpan.org>',
	license            => 'perl',
	create_readme      => 1,
	create_makefile_pl => 'traditional',
	requires           => {
		'FileHandle'      => 0,
		'IO::String'      => '1.06',
		'Time::Piece'     => 0,
		'Class::Accessor' => 0
	},
	build_requires     => {
		'Test::More'  => 0,
		'File::Slurp' => 0
	},
);
$build->create_build_script;