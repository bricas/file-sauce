use inc::Module::Install 0.67;

name 'File-SAUCE';
all_from 'lib/File/SAUCE.pm';

requires 'FileHandle';
requires 'IO::String' => '1.06';
requires 'Time::Piece';
requires 'Class::Accessor';

requires 'Test::More';

auto_install;
WriteAll;
