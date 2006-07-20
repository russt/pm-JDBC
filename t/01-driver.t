#!perl

use Test::More tests => 4;

BEGIN { require "t/test_init.pl" }

use PDBC;

print "CLASSPATH=$ENV{CLASSPATH}\n";
PDBC->load_driver($::PDBC_DRIVER_CLASS);
pass("driver class loaded");

my $timeout = PDBC->getLoginTimeout;
ok defined $timeout, "getLoginTimeout";

my $drivers_enumeration = PDBC->getDrivers;
can_ok $drivers_enumeration, 'hasMoreElements';

my @drivers;
while ($drivers_enumeration->hasMoreElements) {
    my $driver = $drivers_enumeration->nextElement;
    print "Driver: $driver\n";
    push @drivers, $driver;
}
ok @drivers >= 1, "can iterate over drivers";

