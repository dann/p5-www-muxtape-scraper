#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;
use WWW::Muxtape::Scraper;
use URI;
use Perl6::Say;
use YAML::Syck;
$YAML::Syck::ImplicitUnicode = 1;

main();

sub main {
    say "collecting tapes ...";
    my $tapes = collecting_tape_pages(); 
    generate_tape_lists($tapes);
    say "Done! See muxtape.yaml ;)";
}

sub collecting_tape_pages {
    my $muxtape = WWW::Muxtape::Scraper->new;
    my $tape_lists = $muxtape->top_page->scrape();
    my $tapes = [];
    foreach my $tape ( @{$tape_lists}) {
        say 'collecting tape info: ' . $tape->{tapename};
        push @{$tapes}, $muxtape->tape_page->scrape(tapename => $tape->{tapename});
    }
    $tapes;
}

sub generate_tape_lists {
    my $tapes = shift;
    DumpFile("muxtape.yaml",$tapes);
}

__END__
