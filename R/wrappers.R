

#' Utility function for pinning the latest full OPL extract.
#'
#' @param board the Board object from {pins} to attach the data to. Defaults to pins::board_local().
#' @param name optional STRING for the name for the pin. Defaults to "opl-ipf" or "opl-all"
#'
#' @return Same as pin_write
#' @export
#'
pin_opl_full = function(board = pins::board_local(), name = NULL){
  pin_opl(board, ipf = FALSE, name)
}

#' Utility function for pinning the latest IPF-only OPL extract.
#'
#' @param board the Board object from {pins} to attach the data to. Defaults to pins::board_local().
#' @param name optional STRING for the name for the pin. Defaults to "opl-ipf" or "opl-all"
#'
#' @return Same as pin_write
#' @export
#'
pin_opl_ipf = function(board = pins::board_local(), name = NULL){
  pin_opl(board, ipf = TRUE, name)
}
