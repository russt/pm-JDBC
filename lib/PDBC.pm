package PDBC;

use warnings;
use strict;

=head1 NAME

PDBC - Perl 5 interface to Java JDBC with a more DBI-like interface

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use PDBC;

    PDBC->load_driver("org.apache.derby.jdbc.EmbeddedDriver");

    my $con = PDBC->getConnection($url, "test", "test");

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

This PDBC module provides an interface to the Java C<java.sql.*> and
C<javax.sql.*> JDBC APIs. It's actually a layer over the L<JDBC> module that
adds DBI-like methods.

=cut

use warnings;

use base qw(JDBC);

require PDBC::db;
require PDBC::st;

use Memoize;

memoize('_inject_methods');

our $debug = $ENV{PERL_PDBC_DEBUG} || 0;

sub _inject_methods { # memoized
    my ($to_pkg, $from_pkg) = @_;
    no strict 'refs';
    die "$to_pkg is not a package" unless %{$to_pkg.'::'};
    die "$from_pkg is not a package" unless %{$from_pkg.'::'};
    my $to_pkg_sub = $to_pkg . '__PDBC';
    #warn "Installing methods from $from_pkg into $to_pkg_sub\n";
    while (my ($name, $ref) = each %{$from_pkg.'::'}) {
        # import gets added automagically if the pkg is 'use'd.
        # similarly for BEGIN if the pkg contains a use.
        my $new_code_ref = *{$from_pkg.'::'.$name}{CODE}
                or next; # not a sub
        #warn "Installing $name into $to_pkg_sub\n";
        *{$to_pkg_sub . '::' . $name} = $new_code_ref;
    }
    my $super_methods_ref = \@{$from_pkg.'::SUPERS'};
    unshift @{$to_pkg_sub . '::ISA'}, $to_pkg;
    for my $meth (@$super_methods_ref) {
        eval qq{
            package $to_pkg_sub;
            sub SUPER__$meth { return shift->SUPER::$meth(\@_); }
        };
        die $@ if $@;
    }
    return $to_pkg_sub;
}

sub _rebless_handle {
    my ($h, $from_pkg) = @_;
    my $to_pkg_sub = PDBC::_inject_methods(ref $h, $from_pkg);
    bless $h, $to_pkg_sub;
    return $h;
}

sub getConnection {
    my $self = shift;
    my $con = $self->SUPER::getConnection(@_);
    use Devel::Peek;
    #Dump $con;
    $con = PDBC::_rebless_handle($con, 'PDBC::db', [qw(createStatement prepareStatement)]);
    #Dump $con;
    return $con
}


sub import {
    my $pkg = shift;
    #my $callpkg = caller($Exporter::ExportLevel);

    # call standard import to handle anything else
    local $Exporter::ExportLevel = $Exporter::ExportLevel + 1;
    return $pkg->SUPER::import(@_);
}

=head1 METHODS

=head2 load_driver

The load_driver() method is used to load a driver class.

  JDBC->load_driver($driver_class)

is equivalent to the Java:

  java.lang.Class.forName(driver_class).newInstance();

=cut

#sub load_driver;


=head1 FUNCTIONS

=head2 cast

=head2 caught

The cast(), caught() functions of JDBC are also optionally exported by the PDBC module.

=cut

=head1 IMPORTING CONSTANTS

Java JDBC makes use of constants defined in 

  import java.sql.*;
  ...
  stmt = con.prepareStatement(PreparedStatement.SELECT);

the package can also be specified with the C<import> which then avoids the need
to prefix the constant with the class:

  import java.sql.PreparedStatement;
  ...
  stmt = con.prepareStatement(SELECT);

In Perl the corresponding code can be either:

  use JDBC;
  ...
  $stmt = $con->prepareStatement($java::sql::PrepareStatement::SELECT);

or, the rather more friendly:

  use JDBC qw(:PreparedStatement);
  ...
  $stmt = $con->prepareStatement(SELECT);

When importing a JDBC class in this way the JDBC module only imports defined
scalars with all-uppercase names, and it turns them into perl constants so the
C<$> is no longer needed.

All constants in all the java.sql and javax.sql classes can be imported in this way.

=cut

1; # End of JDBC

__END__

=head1 SEE ALSO

L<JDBC>

=head1 AUTHOR

Tim Bunce, C<< <Tim.Bunce@pobox.com> >>

=head1 BUGS

Probably.

=head1 COPYRIGHT & LICENSE

Copyright 2006 Tim Bunce, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
# vim: sw=4
