use inc::Module::Install;
name 'WWW-Muxtape-Scraper';
all_from 'lib/WWW/Muxtape/Scraper.pm';

requires $_ for (qw/ /);

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
