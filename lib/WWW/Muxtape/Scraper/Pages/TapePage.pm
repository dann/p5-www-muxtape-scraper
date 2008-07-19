package WWW::Muxtape::Scraper::Pages::TapePage;
use Moose;
use MooseX::Method;

use Web::Scraper;

has 'rule' => (
    is      => 'rw',
    default => sub {
        scraper {
            process 'div.flag h1',      'title',       'TEXT';
            process 'div.flag h2',      'description', 'TEXT';
            process 'a.drawer_control', 'fans',        sub {
                if ( $_->as_text =~ m/([0-9]+) fans/ ) {
                    return $1;
                }
                else {
                    return '0';
                }
            };
            process 'li.stripe', 'songs[]' => scraper {
                process 'span.artist', 'artist', 'TEXT';
                process 'span.title',  'title',  'TEXT';
            };
        };
    },
);

method scrape => named( 
    tapename => { isa => 'Str', required => 1 }, 
) => sub {
    my ( $self, $args ) = @_;
    my $result = $self->rule->scrape(
        $self->_get_url( tapename => $args->{tapename} ) );
    return $result;
};

method _get_url => named( 
    tapename => { isa => 'Str', required => 1 }, 
) => sub {
    my ( $self, $args ) = @_;
    my $url = 'http://' . $args->{tapename} . '.muxtape.com';
    return URI->new($url);
};



1;
