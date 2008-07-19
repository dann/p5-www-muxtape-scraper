package WWW::Muxtape::Scraper::Pages::TopPage;
use Moose;
use Web::Scraper;
use URI;

has 'rule' => (
    is      => 'ro',
    default => sub {
        scraper {
            process 'ul.featured a', 'tapes[]' => {
                tapename => 'TEXT',
                link     => '@href',
            };
        }
    },
);

sub scrape {
    my $self   = shift;
    my $uri    = $self->_get_url;
    my $result = $self->rule->scrape($uri);
    return $result->{tapes};
}

sub _get_url {
    return URI->new("http://muxtape.com/");
}

1;
