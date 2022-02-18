

#' Utility function for pinning the latest full OPL extract.
#'
#' @param name optional STRING for the name for the pin. Defaults to "opl-ipf" or "opl-all"
#'
#' @return Same as pin_write
#' @export
#'
pin_opl_full = function( name = NULL){
  sql_opl(ipf = FALSE, name)
}

#' Utility function for pinning the latest IPF-only OPL extract.
#'
#' @param name optional STRING for the name for the pin. Defaults to "opl-ipf" or "opl-all"
#'
#' @return Same as pin_write
#' @export
#'
pin_opl_ipf = function(name = NULL){
  sql_opl(ipf = TRUE, name)
}
