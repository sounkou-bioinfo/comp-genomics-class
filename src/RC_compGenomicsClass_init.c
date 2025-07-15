#include <R.h>
#include <Rinternals.h>

extern SEXP RC_len(SEXP x);

// call entries for the package

static const R_CallMethodDef CallEntries[] = {
    {"RC_len", (DL_FUNC) &RC_len, 1},
    {NULL, NULL, 0} 
};

void R_init_compGenomicsClass(DllInfo *info) {
    R_registerRoutines(
    info,      // DllInfo
    NULL,      // .C
    CallEntries,  // .Call
    NULL,      // Fortran
    NULL       // External
  );
   R_useDynamicSymbols(info, FALSE);
   R_forceSymbols(info, FALSE);
}
