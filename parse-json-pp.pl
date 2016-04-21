#!/usr/bin/env perl
use strict;
use feature q(say);
use JSON::PP;
my $json = JSON::PP->new->allow_nonref;
while ( <> ) {
    chomp;
    $json->decode($_);
}
