use ExtUtils::MakeMaker::Dist::Zilla::Develop;
use ExtUtils::Depends;
use Devel::PPPort 0.32_02;

# NOTE:
# This is a very simple Makefile.PL I only use to build the distribution
# locally while working on it.  The real Makefile.PL, with all required
# information like dependencies, is generated later by Dist::Zilla

Devel::PPPort::WriteFile();
WriteMakefile(
    NAME => 'multidimensional',
    ExtUtils::Depends->new('multidimensional', 'B::Hooks::OP::Check')->get_makefile_vars,
);
