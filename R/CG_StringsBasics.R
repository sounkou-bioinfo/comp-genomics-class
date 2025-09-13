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

#' @export
randomCharacters <- function(string, length = 10) {
    .Call(RC_randomCharacters, string, length)
}

#' @title String Concatenation
#' @description A wrapper around `paste0()` for concatenating strings.
#' @param x A character vector.
#' @param ... Additional strings to concatenate.
#' @export
`+` <- function(x, ...) {
    UseMethod("+")
}

#' @export
`+.character` <- function(x, ...) {
    if (length(x) == 0) {
        return(character(0))
    }
    if (length(x) == 1) {
        return(paste0(x, ...))
    }
    if (length(...) == 0) {
        return(x)
    }
    return(paste0(x, ...))
}

#' @export
`+.default` <- function(x, ...) {
    base::`+`(x, ...)
}
