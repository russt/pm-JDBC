#!perl

use Test::More tests => 6;

BEGIN { require "t/test_init.pl" }

use PDBC qw(:ResultSet);

PDBC->load_driver($::PDBC_DRIVER_CLASS);
pass "driver class loaded";

ok $java::sql::ResultSet::TYPE_FORWARD_ONLY;
ok $java::sql::ResultSet::CONCUR_READ_ONLY;

isnt $java::sql::ResultSet::TYPE_FORWARD_ONLY,
     $java::sql::ResultSet::CONCUR_READ_ONLY;

is TYPE_FORWARD_ONLY, $java::sql::ResultSet::TYPE_FORWARD_ONLY;
is CONCUR_READ_ONLY,  $java::sql::ResultSet::CONCUR_READ_ONLY;
