#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>


// length of each string in a character vector
SEXP RC_len( SEXP x){
    if (TYPEOF(x) != STRSXP) {
        Rf_error("x must be a character vector");
    }
    int n = LENGTH(x);
    SEXP res = PROTECT(Rf_allocVector(INTSXP, n));
    for (int i = 0; i < n; i++) {
        // check if string is NA
        if (STRING_ELT(x, i) == NA_STRING) {
            SET_INTEGER_ELT(res, i, NA_INTEGER);
            continue;
        }
        SET_INTEGER_ELT(res, i, Rf_length(STRING_ELT(x, i)));
    }
    UNPROTECT(1);
    return res;
}