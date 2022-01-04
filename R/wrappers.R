

#' Title
#'
#' @param board
#' @param name
#'
#' @return
#' @export
#'
#' @examples
#'
pin_opl_full = function(board, name = NULL){
  pin_opl(board, ipf = FALSE, name)
}

#' Title
#'
#' @param board
#' @param name
#'
#' @return
#' @export
#'
#' @examples
pin_opl_ipf = function(board, name = NULL){
  pin_opl(board, ipf = TRUE, name)
}
