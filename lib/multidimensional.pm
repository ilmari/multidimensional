package multidimensional;
# ABSTRACT: disables multidmensional array emulation

{ use 5.008; }
use strict;
use warnings;

use B::Hooks::OP::Check;
use XSLoader;

XSLoader::load __PACKAGE__, our $VERSION;

=head1 SYNOPSIS

    no multidimensional;

    $hash{1, 2};                # dies
    $hash{join($;, 1, 2)};      # also dies

=head1 DESCRIPTION

Perl's multidimensional array emultaion stems from the days before the
language had references, but these days it mostly serves to bite you
when you typo a hash slice by using the C<$> sigil instead of C<@>.

This module lexically makes using multidmensional array emulation a
fatal error at compile time.

=head1 CAVEAT

Because of the way the module operates (by checking the optree), it also
catches explicit use of C<join($;, ...)> in a hash subscript.  If you
need to do this, either enable multidimensional hash emulation for just
that scope or use one of the following workarounds:

    my $key = join($;, 1, 2);
    $hash{$key};

    my $sep = $;;
    $hash{join($sep, 1, 2)};

    $hash{join(my $sep = $;, 1, 2)};

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
