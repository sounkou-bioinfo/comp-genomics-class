#' @title String Length
#' @description just a wrapper around `nchar()`
#' @param x A character vector.
#' @export
Len <- function(x) {
    stopifnot(is.character(x))
    if (length(x) == 0) {
        return(0L)
    }
    return(nchar(x))
}

#' @title String Length (C version)
#' @description A C implementation of string length calculation.
#' @param x A character vector.
#' @export
CLen <- function(x) {
    stopifnot(is.character(x))
    if (length(x) == 0) {
        return(0L)
    }
    .Call(RC_len, x)
}
