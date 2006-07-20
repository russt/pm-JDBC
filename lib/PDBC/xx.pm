package PDBC::xx;

# package for methods common to drh, dbh & sth

use base qw(Exporter);

# export everything
our @EXPORT = qw();

# $h->DBI::common::debug([$debug_level])  IMA_KEEP_ERR
# $h->DBI::common::dump_handle([$message [, $level]])  IMA_KEEP_ERR
# $h->DBI::common::err()  IMA_KEEP_ERR
# $h->DBI::common::errstr()  IMA_KEEP_ERR
# $h->DBI::common::func()  IMA_FUNC_REDIRECT IMA_KEEP_ERR
# $h->DBI::common::parse_trace_flag($name)  IMA_KEEP_ERR 
# $h->DBI::common::parse_trace_flags($flags)  IMA_KEEP_ERR 
# $h->DBI::common::private_data($;$)  IMA_KEEP_ERR
# $h->DBI::common::set_err($err, $errmsg [, $state, $method, $rv])  IMA_NO_TAINT_IN
# $h->DBI::common::state()  IMA_KEEP_ERR
# $h->DBI::common::swap_inner_handle($h [, $allow_reparent ])  
# $h->DBI::common::trace([$trace_level, [$filename]])  IMA_KEEP_ERR
# $h->DBI::common::trace_msg($message_text [, $min_level ])  IMA_KEEP_ERR

1;
