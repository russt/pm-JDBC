package PDBC::db;

use NEXT;

# $h->DBI::db::begin_work([ \%attr ])  
# $h->DBI::db::clone([\%attr])  
# $h->DBI::db::column_info($catalog, $schema, $table, $column [, \%attr ])   IMA_NOT_FOUND_OKAY 
# $h->DBI::db::commit($;$)  IMA_END_WORK  IMA_NOT_FOUND_OKAY
# $h->DBI::db::connected()  IMA_STUB
# $h->DBI::db::data_sources([\%attr])  
# $h->DBI::db::disconnect($;$)   IMA_NOT_FOUND_OKAY
# $h->DBI::db::do($statement [, \%attr [, @bind_params ] ])   IMA_EXECUTE 
# $h->DBI::db::foreign_key_info($pk_catalog, $pk_schema, $pk_table, $fk_catalog, $fk_schema, $fk_table [, \%attr ])   IMA_NOT_FOUND_OKAY 
# $h->DBI::db::get_info($info_type)   IMA_NOT_FOUND_OKAY 
# $h->DBI::db::last_insert_id($catalog, $schema, $table_name, $field_name [, \%attr ])  IMA_NOT_FOUND_OKAY 
# $h->DBI::db::ping($;$)  IMA_KEEP_ERR 
# $h->DBI::db::prepare($statement [, \%attr])   
# $h->DBI::db::prepare_cached($statement [, \%attr [, $if_active ] ])   
# $h->DBI::db::preparse()  
# $h->DBI::db::primary_key($catalog, $schema, $table [, \%attr ])   
# $h->DBI::db::primary_key_info($catalog, $schema, $table [, \%attr ])   IMA_NOT_FOUND_OKAY 
# $h->DBI::db::quote($string [, $data_type ])  IMA_NO_TAINT_IN IMA_NO_TAINT_OUT 
# $h->DBI::db::quote_identifier($name [, ...] [, \%attr ])  IMA_NO_TAINT_IN IMA_NO_TAINT_OUT 
# $h->DBI::db::rollback($;$)  IMA_END_WORK  IMA_NOT_FOUND_OKAY
# $h->DBI::db::rows()  IMA_KEEP_ERR
# $h->DBI::db::selectall_arrayref($statement [, \%attr [, @bind_params ] ])  
# $h->DBI::db::selectall_hashref($statement, $keyfield [, \%attr [, @bind_params ] ])  
# $h->DBI::db::selectcol_arrayref($statement [, \%attr [, @bind_params ] ])  
# $h->DBI::db::selectrow_array($statement [, \%attr [, @bind_params ] ])  
# $h->DBI::db::selectrow_arrayref($statement [, \%attr [, @bind_params ] ])  
# $h->DBI::db::selectrow_hashref($statement [, \%attr [, @bind_params ] ])  
# $h->DBI::db::table_info($catalog, $schema, $table, $type [, \%attr ])   IMA_NOT_FOUND_OKAY 
# $h->DBI::db::tables($catalog, $schema, $table, $type [, \%attr ])   
# $h->DBI::db::take_imp_data($;$)  
# $h->DBI::db::type_info($data_type)   
# $h->DBI::db::type_info_all($;$)   IMA_NOT_FOUND_OKAY 

use PDBC::xx;

our @SUPERS = qw(createStatement prepareStatement);

sub _rebless_st_handle {
    return PDBC::_rebless_handle(shift, 'PDBC::st');
}

sub createStatement {
    my $self = shift;
    my $stmt = $self->SUPER__createStatement(@_);
    _rebless_st_handle($stmt);
    return $stmt;
}

sub prepareStatement {
    my $self = shift;
    my $stmt = $self->SUPER__prepareStatement(@_);
    _rebless_st_handle($stmt);
    return $stmt;
}


sub foo {
    warn "foo";
}

1;
