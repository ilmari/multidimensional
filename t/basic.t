#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use lib 't/lib';

BEGIN { use_ok 'multidimensional' }

my %a;

foreach my $code (
    '$a{1,2}',
    '{ $a{1,2} }',
    '{ use multidimensional; } $a{1,2}',
    'use multidimensional; { no multidimensional; $a{1,2} }',
) {
    eval "no multidimensional; $code";
    like $@, qr/Use of multidimensional array emulation/;
}

foreach my $code (
    '{ use multidimensional; $a{1,2} }',
    'use multidimensional; $a{1,2}',
    'require MyTest',
    '$a{join(my $sep = $;, 1, 2)}',
    'my $sep = $;; $a{join($sep, 1, 2)}',
    '$a{join($;, 1, 2)}',
) {
    eval "no multidimensional; $code";
    is $@, "";
}

done_testing;
