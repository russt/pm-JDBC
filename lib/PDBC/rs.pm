package PDBC::rs;

#= $h->DBI::st::_get_fbav()  
#  $h->DBI::st::_set_fbav()  
#  $h->DBI::st::bind_col($column, \$var [, \%attr])  
#  $h->DBI::st::bind_columns(\$var1 [, \$var2, ...])  
#  $h->DBI::st::bind_param($parameter, $var [, \%attr])  
#  $h->DBI::st::bind_param_array($parameter, $var [, \%attr])  
#  $h->DBI::st::bind_param_inout($parameter, \$var, $maxlen, [, \%attr])  
#  $h->DBI::st::bind_param_inout_array($parameter, \@var, $maxlen, [, \%attr])  
#  $h->DBI::st::blob_copy_to_file($field, $filename_or_handleref)  
#  $h->DBI::st::blob_read($field, $offset, $len [, \$buf [, $bufoffset]])  
#  $h->DBI::st::cancel($;$)  IMA_NOT_FOUND_OKAY
#  $h->DBI::st::dump_results($maxfieldlen, $linesep, $fieldsep, $filehandle)  
#  $h->DBI::st::execute([@args])  IMA_COPY_STMT IMA_EXECUTE
#  $h->DBI::st::execute_array(\%attribs [, @args])  IMA_COPY_STMT IMA_EXECUTE
#  $h->DBI::st::execute_for_fetch($fetch_sub [, $tuple_status])  IMA_COPY_STMT IMA_EXECUTE
#- $h->DBI::st::fetch()  
#  $h->DBI::st::fetchall_arrayref([ $slice [, $max_rows]])  
#  $h->DBI::st::fetchall_hashref($key_field)  
#- $h->DBI::st::fetchrow()  
#= $h->DBI::st::fetchrow_array()  
#= $h->DBI::st::fetchrow_arrayref()  
#  $h->DBI::st::fetchrow_hashref()  
#  $h->DBI::st::finish($;$)  
#  $h->DBI::st::more_results($;$)  
#  $h->DBI::st::rows()  IMA_KEEP_ERR

sub _get_fbav {
    # XXX should belong to DBI not DBD since the DBI should handle
    # column binding

    my $rs = shift;
    # XXX should return the same row ref each time
    # (to which bound columns would be aliases)
    # for now we'll just return a new one each time
    my $cols = $rs->getMetaData()->getColumnCount();
    my @row;
    $#row = $cols-1; # [0..$cols-1]
    return \@row;
}


sub fetchrow_arrayref {
    my $rs = shift;
    $rs->next or return;
    my $row = $rs->_get_fbav();
    for (0..@$row-1) {
        # assign to each individually so column bindings work
        $row->[$_] = $rs->getString($_+1)
    }
    return \@row;
}


sub fetchrow_array {
    my $h = shift;
    my $row = $h->fetchrow_arrayref or return;
    return @$row;
}


return 1;
