#!perl

use Test::More tests => 1;

BEGIN {
	use_ok( 'PDBC' );
}

diag( "Testing PDBC $PDBC::VERSION, Perl $], $^X" );

require "t/test_init.pl";
