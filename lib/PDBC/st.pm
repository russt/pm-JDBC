package PDBC::st;

use PDBC::rs;

our @SUPERS = qw(executeQuery);

sub executeQuery {
    my $self = shift;
    my $rs = $self->SUPER__executeQuery(@_);
    $rs = PDBC::_rebless_handle($rs, 'PDBC::rs');
    return $rs;
}


return 1;
