#!/usr/bin/env perl
use strict;
use feature q(say);
use JSON::XS;
my $json = JSON::XS->new->allow_nonref;
while ( <> ) {
    chomp;
    $json->decode($_);
}
