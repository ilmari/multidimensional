package multidimensional;
# ABSTRACT: disables multidmensional array emulation

{ use 5.008; }
use strict;
use warnings;

use B::Hooks::OP::Check;
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

Perl's multidimensional array emultaion stems from the days before the
language had references, but these days it mostly serves to bite you
when you typo a hash slice by using the C<$> sigil instead of C<@>.

This module lexically makes using multidmensional array emulation a
fatal error at compile time.

=method unimport

Disables multidimensional array emultaion for the remainder of the
scope being compiled.

=cut

sub unimport { $^H{+(__PACKAGE__)} = 1 }

=method import

Enables multidimensional array emulation for the remainder of the
scope being compiled;

=cut

sub import { $^H{+(__PACKAGE__)} = undef }

=head1 SEE ALSO

L<perlvar/$;>,
L<B::Hooks::OP::Check>.

=cut

1;
