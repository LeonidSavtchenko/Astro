/* Created by Language version: 6.2.0 */
/* NOT VECTORIZED */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "scoplib_ansi.h"
#undef PI
#define nil 0
#include "md1redef.h"
#include "section.h"
#include "nrniv_mf.h"
#include "md2redef.h"
 static void _difusfunc(ldifusfunc2_t, _NrnThread*);
 
#if METHOD3
extern int _method3;
#endif

#if !NRNGPU
#undef exp
#define exp hoc_Exp
extern double hoc_Exp(double);
#endif
 
#define _threadargscomma_ /**/
#define _threadargs_ /**/
 
#define _threadargsprotocomma_ /**/
#define _threadargsproto_ /**/
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 static double *_p; static Datum *_ppvar;
 
#define t nrn_threads->_t
#define dt nrn_threads->_dt
#define frapion0 _p[0]
#define Alpha _p[1]
#define frapion (_p + 2)
#define frapionBuffer (_p + 6)
#define Buffer (_p + 10)
#define frapiono _p[14]
#define frapioni _p[15]
#define Dfrapion (_p + 16)
#define DfrapionBuffer (_p + 20)
#define DBuffer (_p + 24)
#define _g _p[28]
#define _ion_frapiono	*_ppvar[0]._pval
#define _ion_frapioni	*_ppvar[1]._pval
#define _style_frapion	*((int*)_ppvar[2]._pvoid)
#define _ion_difrapiondv	*_ppvar[3]._pval
#define diam	*_ppvar[4]._pval
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 
#if defined(__cplusplus)
extern "C" {
#endif
 static int hoc_nrnpointerindex =  -1;
 /* external NEURON variables */
 /* declaration of user functions */
 static void _hoc_coord(void);
 static int _mechtype;
extern void _nrn_cacheloop_reg(int, int);
extern void hoc_register_prop_size(int, int, int);
extern void hoc_register_limits(int, HocParmLimits*);
extern void hoc_register_units(int, HocParmUnits*);
extern void nrn_promote(Prop*, int, int);
extern Memb_func* memb_func;
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _p = _prop->param; _ppvar = _prop->dparam;
 }
 static void _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range(int);
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 hoc_retpushx(1.);
}
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 "setdata_FRAP", _hoc_setdata,
 "coord_FRAP", _hoc_coord,
 0, 0
};
 /* declare global and static user variables */
#define Buffer0 Buffer0_FRAP
 double Buffer0 = 0;
#define DFree DFree_FRAP
 double DFree = 0.3;
#define vol vol_FRAP
 double vol[4];
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "DFree_FRAP", "um2/ms",
 "vol_FRAP", "1",
 "Buffer0_FRAP", "mM",
 "frapion0_FRAP", "mM",
 "Alpha_FRAP", "1/ms",
 "frapion_FRAP", "mM",
 "frapionBuffer_FRAP", "mM",
 "Buffer_FRAP", "mM",
 0,0
};
 static double delta_t = 0.01;
 static double frapionBuffer0 = 0;
 static double v = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "DFree_FRAP", &DFree_FRAP,
 "Buffer0_FRAP", &Buffer0_FRAP,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 "vol_FRAP", vol_FRAP, 4,
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(Prop*);
static void  nrn_init(_NrnThread*, _Memb_list*, int);
static void nrn_state(_NrnThread*, _Memb_list*, int);
 static void nrn_cur(_NrnThread*, _Memb_list*, int);
static void  nrn_jacob(_NrnThread*, _Memb_list*, int);
 
static int _ode_count(int);
static void _ode_map(int, double**, double**, double*, Datum*, double*, int);
static void _ode_spec(_NrnThread*, _Memb_list*, int);
static void _ode_matsol(_NrnThread*, _Memb_list*, int);
 
#define _cvode_ieq _ppvar[5]._i
 static void _ode_synonym(int, double**, Datum**);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "6.2.0",
"FRAP",
 "frapion0_FRAP",
 "Alpha_FRAP",
 0,
 0,
 "frapion_FRAP[4]",
 "frapionBuffer_FRAP[4]",
 "Buffer_FRAP[4]",
 0,
 0};
 static Symbol* _morphology_sym;
 static Symbol* _frapion_sym;
 static int _type_ifrapion;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 29, _prop);
 	/*initialize range parameters*/
 	frapion0 = 5e-005;
 	Alpha = 0;
 	_prop->param = _p;
 	_prop->param_size = 29;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 6, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_morphology_sym);
 	_ppvar[4]._pval = &prop_ion->param[0]; /* diam */
 prop_ion = need_memb(_frapion_sym);
  _type_ifrapion = prop_ion->_type;
 nrn_check_conc_write(_prop, prop_ion, 1);
 nrn_promote(prop_ion, 3, 0);
 	_ppvar[0]._pval = &prop_ion->param[2]; /* frapiono */
 	_ppvar[1]._pval = &prop_ion->param[1]; /* frapioni */
 	_ppvar[2]._pvoid = (void*)(&(prop_ion->dparam[0]._i)); /* iontype for frapion */
 	_ppvar[3]._pval = &prop_ion->param[4]; /* _ion_difrapiondv */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*f)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _FRAP_reg() {
	int _vectorized = 0;
  _initlists();
 	ion_reg("frapion", 1.0);
 	_morphology_sym = hoc_lookup("morphology");
 	_frapion_sym = hoc_lookup("frapion_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 0);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
  hoc_register_prop_size(_mechtype, 29, 6);
 	nrn_writes_conc(_mechtype, 0);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_synonym(_mechtype, _ode_synonym);
 	hoc_register_ldifus1(_difusfunc);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 FRAP D:/Dropbox/Dropbox/AsrocyteModel/nano/neuronSims/FRAP.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
 static double FARADAY = 9.64853;
 static double PI = 3.14159;
 static double _zcoord_done ;
 static double _zfrat [ 4 ] ;
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int coord();
 extern double *_getelm();
 
#define _MATELM1(_row,_col)	*(_getelm(_row + 1, _col + 1))
 
#define _RHS1(_arg) _coef1[_arg + 1]
 static double *_coef1;
 
#define _linmat1  1
 static void* _sparseobj1;
 static void* _cvsparseobj1;
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[4], _dlist1[4]; static double *_temp1;
 static int state();
 
static int  coord (  ) {
   double _lr , _ldr2 ;
 _lr = 1.0 / 2.0 ;
   _ldr2 = _lr / ( 4.0 - 1.0 ) / 2.0 ;
   vol [ 0 ] = 0.0 ;
   _zfrat [ 0 ] = 2.0 * _lr ;
   {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
     vol [ _li ] = vol [ _li ] + PI * ( _lr - _ldr2 / 2.0 ) * 2.0 * _ldr2 ;
     _lr = _lr - _ldr2 ;
     _zfrat [ _li + 1 ] = 2.0 * PI * _lr / ( 2.0 * _ldr2 ) ;
     _lr = _lr - _ldr2 ;
     vol [ _li + 1 ] = PI * ( _lr + _ldr2 / 2.0 ) * 2.0 * _ldr2 ;
     } }
    return 0; }
 
static void _hoc_coord(void) {
  double _r;
   _r = 1.;
 coord (  );
 hoc_retpushx(_r);
}
 
static int state ()
 {_reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<4;_i++){
  	_RHS1(_i) = -_dt1*(_p[_slist1[_i]] - _p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 0) *= ( diam * diam * vol [ ((int) _i ) ]) ;
_MATELM1(_i + 0, _i + 0) *= ( diam * diam * vol [ ((int) _i ) ]);  } }
 /* COMPARTMENT _li , diam * diam * vol [ ((int) _i ) ] {
     frapion }
   */
 /* LONGITUDINAL_DIFFUSION _lj , DFree * diam * diam * vol [ ((int) _i ) ] {
     frapion }
   */
 {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
     /* ~ frapion [ _li ] <-> frapion [ _li + 1 ] ( DFree * _zfrat [ _li + 1 ] , DFree * _zfrat [ _li + 1 ] )*/
 f_flux =  DFree * _zfrat [ _li + 1 ] * frapion [ _li] ;
 b_flux =  DFree * _zfrat [ _li + 1 ] * frapion [ _li + 1] ;
 _RHS1( 0 +  _li) -= (f_flux - b_flux);
 _RHS1( 0 +  _li + 1) += (f_flux - b_flux);
 
 _term =  DFree * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li)  += _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li)  -= _term;
 _term =  DFree * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li + 1)  -= _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li + 1)  += _term;
 /*REACTION*/
  /* ~ frapion [ _li ] < < ( - Alpha * diam * diam * frapion [ _li ] )*/
 f_flux = b_flux = 0.;
 _RHS1( 0 +  _li) += (b_flux =   ( - Alpha * diam * diam * frapion [ _li ] ) );
 /*FLUX*/
  } }
   frapioni = frapion [ 0 ] ;
     } return _reset;
 }
 
/*CVODE ode begin*/
 static int _ode_spec1() {_reset=0;{
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<4;_i++) _p[_dlist1[_i]] = 0.0;}
 /* COMPARTMENT _li , diam * diam * vol [ ((int) _i ) ] {
   frapion }
 */
 /* LONGITUDINAL_DIFFUSION _lj , DFree * diam * diam * vol [ ((int) _i ) ] {
   frapion }
 */
 {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
   /* ~ frapion [ _li ] <-> frapion [ _li + 1 ] ( DFree * _zfrat [ _li + 1 ] , DFree * _zfrat [ _li + 1 ] )*/
 f_flux =  DFree * _zfrat [ _li + 1 ] * frapion [ _li] ;
 b_flux =  DFree * _zfrat [ _li + 1 ] * frapion [ _li + 1] ;
 Dfrapion [ _li] -= (f_flux - b_flux);
 Dfrapion [ _li + 1] += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ frapion [ _li ] < < ( - Alpha * diam * diam * frapion [ _li ] )*/
 f_flux = b_flux = 0.;
 Dfrapion [ _li] += (b_flux =   ( - Alpha * diam * diam * frapion [ _li ] ) );
 /*FLUX*/
  } }
 frapioni = frapion [ 0 ] ;
 for (_i=0; _i < 4; _i++) { _p[_dlist1[_i + 0]] /= ( diam * diam * vol [ ((int) _i ) ]);}
   } return _reset;
 }
 
/*CVODE matsol*/
 static int _ode_matsol1() {_reset=0;{
 double b_flux, f_flux, _term; int _i;
   b_flux = f_flux = 0.;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<4;_i++){
  	_RHS1(_i) = _dt1*(_p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 0) *= ( diam * diam * vol [ ((int) _i ) ]) ;
_MATELM1(_i + 0, _i + 0) *= ( diam * diam * vol [ ((int) _i ) ]);  } }
 /* COMPARTMENT _li , diam * diam * vol [ ((int) _i ) ] {
 frapion }
 */
 /* LONGITUDINAL_DIFFUSION _lj , DFree * diam * diam * vol [ ((int) _i ) ] {
 frapion }
 */
 {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
 /* ~ frapion [ _li ] <-> frapion [ _li + 1 ] ( DFree * _zfrat [ _li + 1 ] , DFree * _zfrat [ _li + 1 ] )*/
 _term =  DFree * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li)  += _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li)  -= _term;
 _term =  DFree * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li + 1)  -= _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li + 1)  += _term;
 /*REACTION*/
  /* ~ frapion [ _li ] < < ( - Alpha * diam * diam * frapion [ _li ] )*/
 /*FLUX*/
  } }
 frapioni = frapion [ 0 ] ;
   } return _reset;
 }
 
/*CVODE end*/
 
static int _ode_count(int _type){ return 4;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  frapiono = _ion_frapiono;
  frapioni = _ion_frapioni;
  frapioni = _ion_frapioni;
     _ode_spec1 ();
  _ion_frapioni = frapioni;
 }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 4; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 static void _ode_synonym(int _cnt, double** _pp, Datum** _ppd) { 
 	int _i; 
	for (_i=0; _i < _cnt; ++_i) {_p = _pp[_i]; _ppvar = _ppd[_i];
 _ion_frapioni =  frapion [ 0 ] ;
 }}
 
static void _ode_matsol(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  frapiono = _ion_frapiono;
  frapioni = _ion_frapioni;
  frapioni = _ion_frapioni;
 _cvode_sparse(&_cvsparseobj1, 4, _dlist1, _p, _ode_matsol1, &_coef1);
 }}
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_frapion_sym, _ppvar, 0, 2);
   nrn_update_ion_pointer(_frapion_sym, _ppvar, 1, 1);
   nrn_update_ion_pointer(_frapion_sym, _ppvar, 3, 4);
 }
 static void* _difspace1;
extern double nrn_nernst_coef();
static double _difcoef1(int _i, double* _p, Datum* _ppvar, double* _pdvol, double* _pdfcdc, Datum* _thread, _NrnThread* _nt) {
   *_pdvol =  diam * diam * vol [ ((int) _i ) ] ; *_pdfcdc=0.;
   return DFree * diam * diam * vol [ ((int) _i ) ] ;
}
 static void _difusfunc(ldifusfunc2_t _f, _NrnThread* _nt) {int _i;
  for (_i=0; _i < 4; ++_i) (*_f)(_mechtype, _difcoef1, &_difspace1, _i,  2, 16 , _nt);
 }

static void initmodel() {
  int _i; double _save;_ninits++;
 _save = t;
 t = 0.0;
{
 for (_i=0; _i<4; _i++) Buffer[_i] = Buffer0;
 for (_i=0; _i<4; _i++) frapionBuffer[_i] = frapionBuffer0;
 for (_i=0; _i<4; _i++) frapion[_i] = frapion0;
 {
   if ( _zcoord_done  == 0.0 ) {
     _zcoord_done = 1.0 ;
     coord ( _threadargs_ ) ;
     }
   frapioni = frapion0 ;
   {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
     frapion [ _li ] = frapioni ;
     } }
   }
  _sav_indep = t; t = _save;

}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
  frapiono = _ion_frapiono;
  frapioni = _ion_frapioni;
  frapioni = _ion_frapioni;
 initmodel();
  _ion_frapioni = frapioni;
  nrn_wrote_conc(_frapion_sym, (&(_ion_frapioni)) - 1, _style_frapion);
}}

static double _nrn_current(double _v){double _current=0.;v=_v;{
} return _current;
}

static void nrn_cur(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 
}}

static void nrn_jacob(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml];
#if CACHEVEC
  if (use_cachevec) {
	VEC_D(_ni[_iml]) += _g;
  }else
#endif
  {
     _nd = _ml->_nodelist[_iml];
	NODED(_nd) += _g;
  }
 
}}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type){
 double _break, _save;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 _break = t + .5*dt; _save = t;
 v=_v;
{
  frapiono = _ion_frapiono;
  frapioni = _ion_frapioni;
  frapioni = _ion_frapioni;
 { {
 for (; t < _break; t += dt) {
 error = sparse(&_sparseobj1, 4, _slist1, _dlist1, _p, &t, dt, state,&_coef1, _linmat1);
 if(error){fprintf(stderr,"at line 40 in file FRAP.mod:\n    SOLVE state METHOD sparse\n"); nrn_complain(_p); abort_run(error);}
 
}}
 t = _save;
 } {
   }
  _ion_frapioni = frapioni;
}}

}

static void terminal(){}

static void _initlists() {
 int _i; static int _first = 1;
  if (!_first) return;
 for(_i=0;_i<4;_i++){_slist1[0+_i] = (frapion + _i) - _p;  _dlist1[0+_i] = (Dfrapion + _i) - _p;}
_first = 0;
}
