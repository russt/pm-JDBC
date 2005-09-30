package JDBC;

use warnings;
use strict;

=head1 NAME

JDBC - Perl 5 interface to Java JDBC (via Inline::Java)

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use JDBC;

    JDBC->load_driver("org.apache.derby.jdbc.EmbeddedDriver");

    my $con = JDBC->getConnection($url, "test", "test");

    my $s = $con->createStatement();

    $s->executeUpdate("create table foo (foo int, bar varchar(200), primary key (foo))");
    $s->executeUpdate("insert into foo (foo, bar) values (42,'notthis')");
    $s->executeUpdate("insert into foo (foo, bar) values (43,'notthat')");

    my $rs = $s->executeQuery("select foo, bar from foo");
    while ($rs->next) {
	my $foo = $rs->getInt(1);
	my $bar = $rs->getString(2);
	print "row: foo=$foo, bar=$bar\n";
    }

=head1 DESCRIPTION

This JDBC module provides an interface to the Java JDBC APIs.

=cut

our @ISA = qw(Exporter java::sql::DriverManager);

{   # the Inline package needs to be use'd in main in order to
    # get the studied classes to be rooted in main
    package main;
    use Inline ( Java => q{ }, AUTOSTUDY => 1 );
}

use Inline::Java qw(cast caught study_classes);

our @EXPORT_OK = qw(cast caught study_classes);

our $debug = $ENV{PERL_JDBC_DEBUG} || 0;

#java.sql.ParameterMetaData 
my @classes = (qw(
java.sql.Array 
java.sql.BatchUpdateException 
java.sql.Blob 
java.sql.CallableStatement 
java.sql.Clob 
java.sql.Connection 
java.sql.DataTruncation 
java.sql.DatabaseMetaData 
java.sql.Date 
java.sql.Driver 
java.sql.DriverManager 
java.sql.DriverPropertyInfo 
java.sql.PreparedStatement 
java.sql.Ref 
java.sql.ResultSet
java.sql.ResultSetMetaData 
java.sql.SQLData 
java.sql.SQLException 
java.sql.SQLInput 
java.sql.SQLOutput 
java.sql.SQLPermission 
java.sql.SQLWarning 
java.sql.Savepoint 
java.sql.Statement 
java.sql.Struct 
java.sql.Time 
java.sql.Timestamp 
java.sql.Types 
javax.sql.ConnectionEvent 
javax.sql.ConnectionEventListener 
javax.sql.ConnectionPoolDataSource 
javax.sql.DataSource 
javax.sql.PooledConnection 
javax.sql.RowSet 
javax.sql.RowSetEvent 
javax.sql.RowSetInternal 
javax.sql.RowSetListener 
javax.sql.RowSetMetaData 
javax.sql.RowSetReader 
javax.sql.RowSetWriter 
javax.sql.XAConnection 
javax.sql.XADataSource 

));
warn "studying @classes\n" if $debug;
study_classes(\@classes, 'main');

warn "running\n" if $debug;

=head1 METHODS

=head2 load_driver

The JDBC->load_driver($driver_class) method is used to load a driver class.
It's equivalent to the common Java idiom for loading driver classes:

  java.lang.Class.forName(driver_class).newInstance();

=cut

sub load_driver {
    my ($self, $class) = @_;
    study_classes([$class], 'main');
}

# override getDrivers to return an Enumeration (not private class)

sub getDrivers {
    return cast('java.util.Enumeration', shift->SUPER::getDrivers)
}

=head1 FUNCTIONS

=head2 cast

=head2 caught

=head2 study_classes

The cast(), caught(), and study_classes() functions of Inline::JAVA are also
optionally exported by the JDBC module.

=cut

*java_cast = \&cast;


1; # End of JDBC

__END__

=head1 AUTHOR

Tim Bunce, C<< <Tim.Bunce@pobox.com> >>

=head1 BUGS

Firstly try to determine if the problem is related to JDBC or, more likely, the
underlying Inline::Java module.

Please report any bugs or feature requests for JDBC to
C<bug-jdbc@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=JDBC>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

Please report any bugs or feature requests for Inline::Java to XXX

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2005 Tim Bunce, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
# vim: sw=4
