require 5.004;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME	 => 'Time::Beat',
    VERSION_FROM => 'Beat.pm',
    dist         => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
