use Test::Dependencies
	exclude => [qw/Test::Dependencies Test::Base Test::Perl::Critic WWW::Muxtape::Scraper/],
	style   => 'light';
ok_dependencies();
