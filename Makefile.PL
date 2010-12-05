use inc::Module::Install;
name 'Acme-Tsu';
all_from 'lib/Acme/Tsu.pm';

requires 'Acme::EyeDrops';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
