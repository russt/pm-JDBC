#!perl

use Test::More tests => 3;

BEGIN { require "t/test_init.pl" }

use PDBC;

PDBC->load_driver($::PDBC_DRIVER_CLASS);
pass "driver class loaded";

my $con = PDBC->getConnection($::PDBC_DRIVER_URL, "test", "test");
ok ref $con, "got ref";
can_ok $con, 'createStatement';
