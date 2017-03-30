use ExtUtils::MakeMaker::Dist::Zilla::Develop;
use Devel::PPPort 0.32_02;

# NOTE:
# This is a very simple Makefile.PL I only use to build the distribution
# locally while working on it.  The real Makefile.PL, with all required
# information like dependencies, is generated later by Dist::Zilla

Devel::PPPort::WriteFile();

our %WriteMakefileArgs = (
    NAME => 'multidimensional',
);
do './Makefile.depends' or die "Can't do Makefile.depends: " . ($@ || $!);

WriteMakefile(%WriteMakefileArgs);
