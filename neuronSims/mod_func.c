#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _CAl_reg();
extern void _FRAP_reg();
extern void _GluTrans_reg();
extern void _Isin_reg();
extern void _Kir_reg();
extern void _cadifus_reg();
extern void _gap_reg();
extern void _gapCa_reg();
extern void _gapCaSt_reg();
extern void _kdrglia_reg();

modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," CAl.mod");
fprintf(stderr," FRAP.mod");
fprintf(stderr," GluTrans.mod");
fprintf(stderr," Isin.mod");
fprintf(stderr," Kir.mod");
fprintf(stderr," cadifus.mod");
fprintf(stderr," gap.mod");
fprintf(stderr," gapCa.mod");
fprintf(stderr," gapCaSt.mod");
fprintf(stderr," kdrglia.mod");
fprintf(stderr, "\n");
    }
_CAl_reg();
_FRAP_reg();
_GluTrans_reg();
_Isin_reg();
_Kir_reg();
_cadifus_reg();
_gap_reg();
_gapCa_reg();
_gapCaSt_reg();
_kdrglia_reg();
}
