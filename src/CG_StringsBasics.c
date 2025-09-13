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
// sample n random strings from a character vector
SEXP RC_Random( SEXP strings, SEXP n) {
    if(TYPEOF(strings) != STRSXP || Rf_length(strings) != 1) {
        Rf_error("strings must be a character string vector of length 1");
    }
    if(TYPEOF(n) != INTSXP || Rf_length(n) != 1) {
        Rf_error("n must be a single integer");
    }
    int num_samples = INTEGER(n)[0];
    if(num_samples < 1) {
        Rf_error("n must be a positive integer");
    }
    SEXP res = PROTECT(Rf_allocVector(STRSXP, num_samples));
    R_xlen_t len = Rf_length(strings);
    for (R_xlen_t i = 0; i < num_samples; i++) {
        R_xlen_t idx = (R_xlen_t) (unif_rand() * len);
        if (idx >= len) {
            idx = len - 1; // ensure idx is within bounds
        }
        SET_STRING_ELT(res, i, STRING_ELT(strings, idx));
    }
    UNPROTECT(1);
    return res; 
}