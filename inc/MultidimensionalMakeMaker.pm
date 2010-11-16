package inc::MultidimensionalMakeMaker;
use Moose;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

use ExtUtils::Depends;

override _build_WriteMakefile_args => sub {
    my ($self) = @_;
    my $pkg = ExtUtils::Depends->new('multidimensional', 'B::Hooks::OP::Check');

    return +{
        %{super()},
        $pkg->get_makefile_vars,
    };
};

__PACKAGE__->meta->make_immutable;
