use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'PDBC',
    license             => 'perl',
    dist_author         => 'Tim Bunce <Tim.Bunce@pobox.com>',
    dist_version_from   => 'lib/PDBC.pm',
    requires => {
        'JDBC'         => 0,
        'Test::More'   => 0,
    },
    add_to_cleanup      => [ ],
);

$builder->create_build_script();
