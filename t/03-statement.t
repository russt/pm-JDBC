#!perl

use Test::More tests => 6;

BEGIN { require "t/test_init.pl" }

use PDBC;

PDBC->load_driver($::PDBC_DRIVER_CLASS);
pass "driver class loaded";

my $con = PDBC->getConnection($::PDBC_DRIVER_URL, "test", "test");
ok $con;
print "Connection: $con\n\n";

my $s1 = $con->createStatement();
ok $s1;
print "Statement: $s1\n\n";

$s1->executeUpdate("create table foo (foo int, bar varchar(200), primary key (foo))");
$s1->executeUpdate("insert into foo (foo, bar) values (42,'notthis')");
$s1->executeUpdate("insert into foo (foo, bar) values (43,'notthat')");

my $rs = $s1->executeQuery("select foo, bar from foo");
ok $rs;
print "ResultSet: $rs\n\n";

while (my @row = $rs->fetchrow_array) {
    my ($foo, $bar) = @row;
    print "row: foo=$foo, bar=$bar\n";
}

my $s2 = $con->createStatement(
	$java::sql::ResultSet::TYPE_FORWARD_ONLY,
	$java::sql::ResultSet::CONCUR_READ_ONLY
);
ok ref $s2, "got ref";
can_ok $s2, 'executeUpdate';

