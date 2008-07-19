package WWW::Muxtape::Scraper;
use Moose;

use Module::Pluggable::Fast
    name   => 'scrapers',
    search => [qw( WWW::Muxtape::Scraper::Pages )];
use String::CamelCase qw( decamelize );

our $VERSION = '0.01';

sub before_ {
    my $self = shift;
    $self->_load_scrapers;

}

around 'new' => sub {
    my ( $next, $class, @args ) = @_;
    $class->_load_scrapers;
    return $next->( $class, @args );
};

sub _load_scrapers {
    foreach my $scraper ( __PACKAGE__->scrapers ) {
        my ($name) = decamelize( ref $scraper ) =~ /(\w+)$/;
        warn $name;

        __PACKAGE__->meta->add_attribute(
            $name => (
                is      => "rw",
                default => sub {
                    return $scraper;
                }
            )
        );
    }
}

1;
__END__

=head1 NAME

WWW::Muxtape::Scraper -

=head1 SYNOPSIS

  use WWW::Muxtape::Scraper;

  use WWW::Muxtape::Scraper;
  my $muxtape = WWW::Muxtape::Scraper->new;
  my $tape_lists = $muxtape->top_page->scrape();
  my $tapes = []; 
  foreach my $tape ( @{$tape_lists}) {
        push @{$tapes}, $muxtape->tape_page->scrape(tapename => $tape->{tapename});
  }   

=head1 DESCRIPTION

WWW::Muxtape::Scraper is

=head1 AUTHOR

dann E<lt>techmemo@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
