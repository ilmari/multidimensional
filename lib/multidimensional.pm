package multidimensional;
# ABSTRACT: disables multidimensional array emulation

{ use 5.008001; }
use strict;
use warnings;

use if "$]" < 5.012, 'Lexical::SealRequireHints';
use B::Hooks::OP::Check 0.19;
use XSLoader;

XSLoader::load(
    __PACKAGE__,
    # we need to be careful not to touch $VERSION at compile time, otherwise
    # DynaLoader will assume it's set and check against it, which will cause
    # fail when being run in the checkout without dzil having set the actual
    # $VERSION
    exists $multidimensional::{VERSION} ? ${ $multidimensional::{VERSION} } : (),
);

=head1 SYNOPSIS

    no multidimensional;

    $hash{1, 2};                # dies
    $hash{join($;, 1, 2)};      # doesn't die

=head1 DESCRIPTION

Perl's multidimensional array emulation stems from the days before the
language had references, but these days it mostly serves to bite you
when you typo a hash slice by using the C<$> sigil instead of C<@>.

This module lexically makes using multidimensional array emulation a
fatal error at compile time.

=method unimport

Disables multidimensional array emulation for the remainder of the
scope being compiled.

=cut

sub unimport {
    $^H |= 0x20000; # HINT_LOCALIZE_HH, to make %^H lexical on 5.8
    $^H{__PACKAGE__.'/disabled'} = 1;
}

=method import

Enables multidimensional array emulation for the remainder of the
scope being compiled;

=cut

sub import { delete $^H{__PACKAGE__.'/disabled'} }

=head1 SEE ALSO

L<perlvar/$;>,
L<B::Hooks::OP::Check>.

=cut

1;
