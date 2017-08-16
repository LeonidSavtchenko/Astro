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
#define cai0 _p[0]
#define fluo _p[1]
#define fluoNew _p[2]
#define alpha _p[3]
#define ica_pmp _p[4]
#define ca (_p + 5)
#define bufs (_p + 9)
#define cabufs (_p + 13)
#define bufm (_p + 17)
#define cabufm (_p + 21)
#define hc (_p + 25)
#define ho (_p + 29)
#define ica _p[33]
#define ica_pmp_last _p[34]
#define parea _p[35]
#define sump _p[36]
#define cai _p[37]
#define cao _p[38]
#define bufs_0 _p[39]
#define bufm_0 _p[40]
#define ip3i _p[41]
#define L (_p + 42)
#define Dca (_p + 46)
#define Dbufs (_p + 50)
#define Dcabufs (_p + 54)
#define Dbufm (_p + 58)
#define Dcabufm (_p + 62)
#define Dhc (_p + 66)
#define Dho (_p + 70)
#define _g _p[74]
#define _ion_cao	*_ppvar[0]._pval
#define _ion_cai	*_ppvar[1]._pval
#define _ion_ica	*_ppvar[2]._pval
#define _ion_dicadv	*_ppvar[3]._pval
#define _style_ca	*((int*)_ppvar[4]._pvoid)
#define _ion_ip3i	*_ppvar[5]._pval
#define _ion_diip3dv	*_ppvar[6]._pval
#define diam	*_ppvar[7]._pval
 
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
 static void _hoc_factors(void);
 static void _hoc_u(void);
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
 "setdata_cadifus", _hoc_setdata,
 "factors_cadifus", _hoc_factors,
 "u_cadifus", _hoc_u,
 0, 0
};
#define u u_cadifus
 extern double u( double , double );
 /* declare global and static user variables */
#define BufferAlpha BufferAlpha_cadifus
 double BufferAlpha = 100;
#define DBufm DBufm_cadifus
 double DBufm = 0.05;
#define DCa DCa_cadifus
 double DCa = 0.22;
#define Kinh Kinh_cadifus
 double Kinh = 0.0002;
#define Kact Kact_cadifus
 double Kact = 0.0003;
#define Kip3 Kip3_cadifus
 double Kip3 = 0.0008;
#define Kp Kp_cadifus
 double Kp = 0.00027;
#define KDm KDm_cadifus
 double KDm = 0.24;
#define KDs KDs_cadifus
 double KDs = 10;
#define TBufm TBufm_cadifus
 double TBufm = 0.075;
#define TBufs TBufs_cadifus
 double TBufs = 0.45;
#define caer caer_cadifus
 double caer = 0.4;
#define cath cath_cadifus
 double cath = 0.0002;
#define gamma gamma_cadifus
 double gamma = 8;
#define jmax jmax_cadifus
 double jmax = 0.0035;
#define kon kon_cadifus
 double kon = 2.7;
#define kfm kfm_cadifus
 double kfm = 1000;
#define kfs kfs_cadifus
 double kfs = 1000;
#define vmax vmax_cadifus
 double vmax = 3.75e-006;
#define vrat vrat_cadifus
 double vrat[4];
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "DCa_cadifus", "um2/ms",
 "TBufs_cadifus", "mM",
 "kfs_cadifus", "/mM-ms",
 "KDs_cadifus", "uM",
 "TBufm_cadifus", "mM",
 "kfm_cadifus", "/mM-ms",
 "KDm_cadifus", "uM",
 "DBufm_cadifus", "um2/ms",
 "cath_cadifus", "mM",
 "gamma_cadifus", "um/s",
 "vmax_cadifus", "mM/ms",
 "Kp_cadifus", "mM",
 "jmax_cadifus", "mM/ms",
 "caer_cadifus", "mM",
 "Kip3_cadifus", "mM",
 "Kact_cadifus", "mM",
 "kon_cadifus", "/mM-ms",
 "Kinh_cadifus", "mM",
 "vrat_cadifus", "1",
 "cai0_cadifus", "mM",
 "fluo_cadifus", "mM",
 "alpha_cadifus", "1",
 "ca_cadifus", "mM",
 "bufs_cadifus", "mM",
 "cabufs_cadifus", "mM",
 "bufm_cadifus", "mM",
 "cabufm_cadifus", "mM",
 "ica_pmp_cadifus", "mA/cm2",
 0,0
};
 static double bufm0 = 0;
 static double bufs0 = 0;
 static double cabufm0 = 0;
 static double cabufs0 = 0;
 static double ca0 = 0;
 static double delta_t = 0.01;
 static double ho0 = 0;
 static double hc0 = 0;
 static double v = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "DCa_cadifus", &DCa_cadifus,
 "BufferAlpha_cadifus", &BufferAlpha_cadifus,
 "TBufs_cadifus", &TBufs_cadifus,
 "kfs_cadifus", &kfs_cadifus,
 "KDs_cadifus", &KDs_cadifus,
 "TBufm_cadifus", &TBufm_cadifus,
 "kfm_cadifus", &kfm_cadifus,
 "KDm_cadifus", &KDm_cadifus,
 "DBufm_cadifus", &DBufm_cadifus,
 "cath_cadifus", &cath_cadifus,
 "gamma_cadifus", &gamma_cadifus,
 "vmax_cadifus", &vmax_cadifus,
 "Kp_cadifus", &Kp_cadifus,
 "jmax_cadifus", &jmax_cadifus,
 "caer_cadifus", &caer_cadifus,
 "Kip3_cadifus", &Kip3_cadifus,
 "Kact_cadifus", &Kact_cadifus,
 "kon_cadifus", &kon_cadifus,
 "Kinh_cadifus", &Kinh_cadifus,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 "vrat_cadifus", vrat_cadifus, 4,
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
 
#define _cvode_ieq _ppvar[8]._i
 static void _ode_synonym(int, double**, Datum**);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "6.2.0",
"cadifus",
 "cai0_cadifus",
 "fluo_cadifus",
 "fluoNew_cadifus",
 "alpha_cadifus",
 0,
 "ica_pmp_cadifus",
 0,
 "ca_cadifus[4]",
 "bufs_cadifus[4]",
 "cabufs_cadifus[4]",
 "bufm_cadifus[4]",
 "cabufm_cadifus[4]",
 "hc_cadifus[4]",
 "ho_cadifus[4]",
 0,
 0};
 static Symbol* _morphology_sym;
 static Symbol* _ca_sym;
 static int _type_ica;
 static Symbol* _ip3_sym;
 static int _type_iip3;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 75, _prop);
 	/*initialize range parameters*/
 	cai0 = 5e-005;
 	fluo = 0;
 	fluoNew = 0;
 	alpha = 1;
 	_prop->param = _p;
 	_prop->param_size = 75;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 9, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_morphology_sym);
 	_ppvar[7]._pval = &prop_ion->param[0]; /* diam */
 prop_ion = need_memb(_ca_sym);
  _type_ica = prop_ion->_type;
 nrn_check_conc_write(_prop, prop_ion, 1);
 nrn_promote(prop_ion, 3, 0);
 	_ppvar[0]._pval = &prop_ion->param[2]; /* cao */
 	_ppvar[1]._pval = &prop_ion->param[1]; /* cai */
 	_ppvar[2]._pval = &prop_ion->param[3]; /* ica */
 	_ppvar[3]._pval = &prop_ion->param[4]; /* _ion_dicadv */
 	_ppvar[4]._pvoid = (void*)(&(prop_ion->dparam[0]._i)); /* iontype for ca */
 prop_ion = need_memb(_ip3_sym);
  _type_iip3 = prop_ion->_type;
 nrn_promote(prop_ion, 1, 0);
 	_ppvar[5]._pval = &prop_ion->param[1]; /* ip3i */
 	_ppvar[6]._pval = &prop_ion->param[4]; /* _ion_diip3dv */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 "ca_cadifus", 1e-007,
 "bufs_cadifus", 0.001,
 "cabufs_cadifus", 1e-007,
 "bufm_cadifus", 0.0001,
 "cabufm_cadifus", 1e-008,
 0,0
};
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*f)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _cadifus_reg() {
	int _vectorized = 0;
  _initlists();
 	ion_reg("ca", -10000.);
 	ion_reg("ip3", 1.0);
 	_morphology_sym = hoc_lookup("morphology");
 	_ca_sym = hoc_lookup("ca_ion");
 	_ip3_sym = hoc_lookup("ip3_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 0);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
  hoc_register_prop_size(_mechtype, 75, 9);
 	nrn_writes_conc(_mechtype, 0);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_synonym(_mechtype, _ode_synonym);
 	hoc_register_ldifus1(_difusfunc);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 cadifus D:/Dropbox/Dropbox/AsrocyteModel/nano/neuronSims/cadifus.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
 static double FARADAY = 9.64853;
 static double PI = 3.14159;
 static double volo = 1e10;
 static double _zfactors_done , _zjx ;
 static double _zfrat [ 4 ] ;
 static double _zdsq , _zdsqvol ;
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int factors();
 extern double *_getelm();
 
#define _MATELM1(_row,_col)	*(_getelm(_row + 1, _col + 1))
 
#define _RHS1(_arg) _coef1[_arg + 1]
 static double *_coef1;
 
#define _linmat1  0
 static void* _sparseobj1;
 static void* _cvsparseobj1;
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[28], _dlist1[28]; static double *_temp1;
 static int state();
 
static int  factors (  ) {
   double _lr , _ldr2 ;
 _lr = 1.0 / 2.0 ;
   _ldr2 = _lr / ( 4.0 - 1.0 ) / 2.0 ;
   vrat [ 0 ] = 0.0 ;
   _zfrat [ 0 ] = 2.0 * _lr ;
   {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
     vrat [ _li ] = vrat [ _li ] + PI * ( _lr - _ldr2 / 2.0 ) * 2.0 * _ldr2 ;
     _lr = _lr - _ldr2 ;
     _zfrat [ _li + 1 ] = 2.0 * PI * _lr / ( 2.0 * _ldr2 ) ;
     _lr = _lr - _ldr2 ;
     vrat [ _li + 1 ] = PI * ( _lr + _ldr2 / 2.0 ) * 2.0 * _ldr2 ;
     } }
    return 0; }
 
static void _hoc_factors(void) {
  double _r;
   _r = 1.;
 factors (  );
 hoc_retpushx(_r);
}
 
static int state ()
 {_reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<28;_i++){
  	_RHS1(_i) = -_dt1*(_p[_slist1[_i]] - _p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 0) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 0, _i + 0) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 4) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 4, _i + 4) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 8) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 8, _i + 8) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 12) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 12, _i + 12) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 16) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 16, _i + 16) *= ( diam * diam * vrat [ ((int) _i ) ]);  } }
 /* COMPARTMENT _li , diam * diam * vrat [ ((int) _i ) ] {
     ca bufs cabufs bufm cabufm }
   */
 /* COMPARTMENT volo {
     }
   */
 /* LONGITUDINAL_DIFFUSION _li , DCa * diam * diam * vrat [ ((int) _i ) ] {
     ca }
   */
 /* LONGITUDINAL_DIFFUSION _li , DBufm * diam * diam * vrat [ ((int) _i ) ] {
     bufm cabufm }
   */
 /* ~ ca [ 0 ] <-> sump ( ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) , ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) )*/
 f_flux =  ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) * ca [ 0] ;
 b_flux =  ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) * sump ;
 _RHS1( 16 +  0) -= (f_flux - b_flux);
 
 _term =  ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) ;
 _MATELM1( 16 +  0 ,16 +  0)  += _term;
 /*REACTION*/
  ica_pmp = 2.0 * FARADAY * ( f_flux - b_flux ) / parea ;
   /* ~ ca [ 0 ] < < ( - ( ica - ica_pmp_last ) * PI * diam / ( 2.0 * FARADAY ) )*/
 f_flux = b_flux = 0.;
 _RHS1( 16 +  0) += (b_flux =   ( - ( ica - ica_pmp_last ) * PI * diam / ( 2.0 * FARADAY ) ) );
 /*FLUX*/
  {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
     /* ~ ca [ _li ] <-> ca [ _li + 1 ] ( DCa * _zfrat [ _li + 1 ] , DCa * _zfrat [ _li + 1 ] )*/
 f_flux =  DCa * _zfrat [ _li + 1 ] * ca [ _li] ;
 b_flux =  DCa * _zfrat [ _li + 1 ] * ca [ _li + 1] ;
 _RHS1( 16 +  _li) -= (f_flux - b_flux);
 _RHS1( 16 +  _li + 1) += (f_flux - b_flux);
 
 _term =  DCa * _zfrat [ _li + 1 ] ;
 _MATELM1( 16 +  _li ,16 +  _li)  += _term;
 _MATELM1( 16 +  _li + 1 ,16 +  _li)  -= _term;
 _term =  DCa * _zfrat [ _li + 1 ] ;
 _MATELM1( 16 +  _li ,16 +  _li + 1)  -= _term;
 _MATELM1( 16 +  _li + 1 ,16 +  _li + 1)  += _term;
 /*REACTION*/
  /* ~ bufm [ _li ] <-> bufm [ _li + 1 ] ( DBufm * _zfrat [ _li + 1 ] , DBufm * _zfrat [ _li + 1 ] )*/
 f_flux =  DBufm * _zfrat [ _li + 1 ] * bufm [ _li] ;
 b_flux =  DBufm * _zfrat [ _li + 1 ] * bufm [ _li + 1] ;
 _RHS1( 0 +  _li) -= (f_flux - b_flux);
 _RHS1( 0 +  _li + 1) += (f_flux - b_flux);
 
 _term =  DBufm * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li)  += _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li)  -= _term;
 _term =  DBufm * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li + 1)  -= _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li + 1)  += _term;
 /*REACTION*/
  } }
   _zdsq = diam * diam ;
   {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
     _zdsqvol = _zdsq * vrat [ _li ] ;
     /* ~ ca [ _li ] + bufs [ _li ] <-> cabufs [ _li ] ( kfs * _zdsqvol , ( 0.001 ) * KDs * kfs * _zdsqvol )*/
 f_flux =  kfs * _zdsqvol * bufs [ _li] * ca [ _li] ;
 b_flux =  ( 0.001 ) * KDs * kfs * _zdsqvol * cabufs [ _li] ;
 _RHS1( 4 +  _li) -= (f_flux - b_flux);
 _RHS1( 16 +  _li) -= (f_flux - b_flux);
 _RHS1( 12 +  _li) += (f_flux - b_flux);
 
 _term =  kfs * _zdsqvol * ca [ _li] ;
 _MATELM1( 4 +  _li ,4 +  _li)  += _term;
 _MATELM1( 16 +  _li ,4 +  _li)  += _term;
 _MATELM1( 12 +  _li ,4 +  _li)  -= _term;
 _term =  kfs * _zdsqvol * bufs [ _li] ;
 _MATELM1( 4 +  _li ,16 +  _li)  += _term;
 _MATELM1( 16 +  _li ,16 +  _li)  += _term;
 _MATELM1( 12 +  _li ,16 +  _li)  -= _term;
 _term =  ( 0.001 ) * KDs * kfs * _zdsqvol ;
 _MATELM1( 4 +  _li ,12 +  _li)  -= _term;
 _MATELM1( 16 +  _li ,12 +  _li)  -= _term;
 _MATELM1( 12 +  _li ,12 +  _li)  += _term;
 /*REACTION*/
  /* ~ ca [ _li ] + bufm [ _li ] <-> cabufm [ _li ] ( kfm * _zdsqvol , ( 0.001 ) * KDm * kfm * _zdsqvol )*/
 f_flux =  kfm * _zdsqvol * bufm [ _li] * ca [ _li] ;
 b_flux =  ( 0.001 ) * KDm * kfm * _zdsqvol * cabufm [ _li] ;
 _RHS1( 0 +  _li) -= (f_flux - b_flux);
 _RHS1( 16 +  _li) -= (f_flux - b_flux);
 _RHS1( 8 +  _li) += (f_flux - b_flux);
 
 _term =  kfm * _zdsqvol * ca [ _li] ;
 _MATELM1( 0 +  _li ,0 +  _li)  += _term;
 _MATELM1( 16 +  _li ,0 +  _li)  += _term;
 _MATELM1( 8 +  _li ,0 +  _li)  -= _term;
 _term =  kfm * _zdsqvol * bufm [ _li] ;
 _MATELM1( 0 +  _li ,16 +  _li)  += _term;
 _MATELM1( 16 +  _li ,16 +  _li)  += _term;
 _MATELM1( 8 +  _li ,16 +  _li)  -= _term;
 _term =  ( 0.001 ) * KDm * kfm * _zdsqvol ;
 _MATELM1( 0 +  _li ,8 +  _li)  -= _term;
 _MATELM1( 16 +  _li ,8 +  _li)  -= _term;
 _MATELM1( 8 +  _li ,8 +  _li)  += _term;
 /*REACTION*/
  } }
   {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
     _zdsqvol = _zdsq * vrat [ _li ] ;
     /* ~ ca [ _li ] < < ( - _zdsqvol * alpha * vmax * pow( ca [ _li ] , 2.0 ) / ( pow( ca [ _li ] , 2.0 ) + pow( Kp , 2.0 ) ) )*/
 f_flux = b_flux = 0.;
 _RHS1( 16 +  _li) += (b_flux =   ( - _zdsqvol * alpha * vmax * pow( ca [ _li ] , 2.0 ) / ( pow( ca [ _li ] , 2.0 ) + pow( Kp , 2.0 ) ) ) );
 /*FLUX*/
  /* ~ hc [ _li ] <-> ho [ _li ] ( kon * Kinh , kon * ca [ _li ] )*/
 f_flux =  kon * Kinh * hc [ _li] ;
 b_flux =  kon * ca [ _li ] * ho [ _li] ;
 _RHS1( 24 +  _li) -= (f_flux - b_flux);
 _RHS1( 20 +  _li) += (f_flux - b_flux);
 
 _term =  kon * Kinh ;
 _MATELM1( 24 +  _li ,24 +  _li)  += _term;
 _MATELM1( 20 +  _li ,24 +  _li)  -= _term;
 _term =  kon * ca [ _li ] ;
 _MATELM1( 24 +  _li ,20 +  _li)  -= _term;
 _MATELM1( 20 +  _li ,20 +  _li)  += _term;
 /*REACTION*/
  /* ~ ca [ _li ] < < ( _zdsqvol * alpha * jmax * ( 1.0 - ( ca [ _li ] / caer ) ) * pow( ( ( ip3i / ( ip3i + Kip3 ) ) * ( ca [ _li ] / ( ca [ _li ] + Kact ) ) * ho [ _li ] ) , 3.0 ) )*/
 f_flux = b_flux = 0.;
 _RHS1( 16 +  _li) += (b_flux =   ( _zdsqvol * alpha * jmax * ( 1.0 - ( ca [ _li ] / caer ) ) * pow( ( ( ip3i / ( ip3i + Kip3 ) ) * ( ca [ _li ] / ( ca [ _li ] + Kact ) ) * ho [ _li ] ) , 3.0 ) ) );
 /*FLUX*/
  /* ~ ca [ _li ] < < ( _zdsqvol * alpha * L [ _li ] * ( 1.0 - ( ca [ _li ] / caer ) ) )*/
 f_flux = b_flux = 0.;
 _RHS1( 16 +  _li) += (b_flux =   ( _zdsqvol * alpha * L [ _li ] * ( 1.0 - ( ca [ _li ] / caer ) ) ) );
 /*FLUX*/
  } }
   cai = ca [ 0 ] ;
   fluo = cabufm [ 0 ] ;
   fluoNew = ( BufferAlpha * cabufm [ 0 ] + ca [ 0 ] - BufferAlpha * ( TBufm - bufm_0 ) - cai0 ) / ( BufferAlpha * ( TBufm - bufm_0 ) + cai0 ) ;
     } return _reset;
 }
 
double u (  double _lx , double _lth ) {
   double _lu;
 if ( _lx > _lth ) {
     _lu = 1.0 ;
     }
   else {
     _lu = 0.0 ;
     }
   
return _lu;
 }
 
static void _hoc_u(void) {
  double _r;
   _r =  u (  *getarg(1) , *getarg(2) );
 hoc_retpushx(_r);
}
 
/*CVODE ode begin*/
 static int _ode_spec1() {_reset=0;{
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<28;_i++) _p[_dlist1[_i]] = 0.0;}
 /* COMPARTMENT _li , diam * diam * vrat [ ((int) _i ) ] {
   ca bufs cabufs bufm cabufm }
 */
 /* COMPARTMENT volo {
   }
 */
 /* LONGITUDINAL_DIFFUSION _li , DCa * diam * diam * vrat [ ((int) _i ) ] {
   ca }
 */
 /* LONGITUDINAL_DIFFUSION _li , DBufm * diam * diam * vrat [ ((int) _i ) ] {
   bufm cabufm }
 */
 /* ~ ca [ 0 ] <-> sump ( ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) , ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) )*/
 f_flux =  ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) * ca [ 0] ;
 b_flux =  ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) * sump ;
 Dca [ 0] -= (f_flux - b_flux);
 
 /*REACTION*/
  ica_pmp = 2.0 * FARADAY * ( f_flux - b_flux ) / parea ;
 /* ~ ca [ 0 ] < < ( - ( ica - ica_pmp_last ) * PI * diam / ( 2.0 * FARADAY ) )*/
 f_flux = b_flux = 0.;
 Dca [ 0] += (b_flux =   ( - ( ica - ica_pmp_last ) * PI * diam / ( 2.0 * FARADAY ) ) );
 /*FLUX*/
  {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
   /* ~ ca [ _li ] <-> ca [ _li + 1 ] ( DCa * _zfrat [ _li + 1 ] , DCa * _zfrat [ _li + 1 ] )*/
 f_flux =  DCa * _zfrat [ _li + 1 ] * ca [ _li] ;
 b_flux =  DCa * _zfrat [ _li + 1 ] * ca [ _li + 1] ;
 Dca [ _li] -= (f_flux - b_flux);
 Dca [ _li + 1] += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ bufm [ _li ] <-> bufm [ _li + 1 ] ( DBufm * _zfrat [ _li + 1 ] , DBufm * _zfrat [ _li + 1 ] )*/
 f_flux =  DBufm * _zfrat [ _li + 1 ] * bufm [ _li] ;
 b_flux =  DBufm * _zfrat [ _li + 1 ] * bufm [ _li + 1] ;
 Dbufm [ _li] -= (f_flux - b_flux);
 Dbufm [ _li + 1] += (f_flux - b_flux);
 
 /*REACTION*/
  } }
 _zdsq = diam * diam ;
 {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
   _zdsqvol = _zdsq * vrat [ _li ] ;
   /* ~ ca [ _li ] + bufs [ _li ] <-> cabufs [ _li ] ( kfs * _zdsqvol , ( 0.001 ) * KDs * kfs * _zdsqvol )*/
 f_flux =  kfs * _zdsqvol * bufs [ _li] * ca [ _li] ;
 b_flux =  ( 0.001 ) * KDs * kfs * _zdsqvol * cabufs [ _li] ;
 Dbufs [ _li] -= (f_flux - b_flux);
 Dca [ _li] -= (f_flux - b_flux);
 Dcabufs [ _li] += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ ca [ _li ] + bufm [ _li ] <-> cabufm [ _li ] ( kfm * _zdsqvol , ( 0.001 ) * KDm * kfm * _zdsqvol )*/
 f_flux =  kfm * _zdsqvol * bufm [ _li] * ca [ _li] ;
 b_flux =  ( 0.001 ) * KDm * kfm * _zdsqvol * cabufm [ _li] ;
 Dbufm [ _li] -= (f_flux - b_flux);
 Dca [ _li] -= (f_flux - b_flux);
 Dcabufm [ _li] += (f_flux - b_flux);
 
 /*REACTION*/
  } }
 {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
   _zdsqvol = _zdsq * vrat [ _li ] ;
   /* ~ ca [ _li ] < < ( - _zdsqvol * alpha * vmax * pow( ca [ _li ] , 2.0 ) / ( pow( ca [ _li ] , 2.0 ) + pow( Kp , 2.0 ) ) )*/
 f_flux = b_flux = 0.;
 Dca [ _li] += (b_flux =   ( - _zdsqvol * alpha * vmax * pow( ca [ _li ] , 2.0 ) / ( pow( ca [ _li ] , 2.0 ) + pow( Kp , 2.0 ) ) ) );
 /*FLUX*/
  /* ~ hc [ _li ] <-> ho [ _li ] ( kon * Kinh , kon * ca [ _li ] )*/
 f_flux =  kon * Kinh * hc [ _li] ;
 b_flux =  kon * ca [ _li ] * ho [ _li] ;
 Dhc [ _li] -= (f_flux - b_flux);
 Dho [ _li] += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ ca [ _li ] < < ( _zdsqvol * alpha * jmax * ( 1.0 - ( ca [ _li ] / caer ) ) * pow( ( ( ip3i / ( ip3i + Kip3 ) ) * ( ca [ _li ] / ( ca [ _li ] + Kact ) ) * ho [ _li ] ) , 3.0 ) )*/
 f_flux = b_flux = 0.;
 Dca [ _li] += (b_flux =   ( _zdsqvol * alpha * jmax * ( 1.0 - ( ca [ _li ] / caer ) ) * pow( ( ( ip3i / ( ip3i + Kip3 ) ) * ( ca [ _li ] / ( ca [ _li ] + Kact ) ) * ho [ _li ] ) , 3.0 ) ) );
 /*FLUX*/
  /* ~ ca [ _li ] < < ( _zdsqvol * alpha * L [ _li ] * ( 1.0 - ( ca [ _li ] / caer ) ) )*/
 f_flux = b_flux = 0.;
 Dca [ _li] += (b_flux =   ( _zdsqvol * alpha * L [ _li ] * ( 1.0 - ( ca [ _li ] / caer ) ) ) );
 /*FLUX*/
  } }
 cai = ca [ 0 ] ;
 fluo = cabufm [ 0 ] ;
 fluoNew = ( BufferAlpha * cabufm [ 0 ] + ca [ 0 ] - BufferAlpha * ( TBufm - bufm_0 ) - cai0 ) / ( BufferAlpha * ( TBufm - bufm_0 ) + cai0 ) ;
 for (_i=0; _i < 4; _i++) { _p[_dlist1[_i + 0]] /= ( diam * diam * vrat [ ((int) _i ) ]);}
 for (_i=0; _i < 4; _i++) { _p[_dlist1[_i + 4]] /= ( diam * diam * vrat [ ((int) _i ) ]);}
 for (_i=0; _i < 4; _i++) { _p[_dlist1[_i + 8]] /= ( diam * diam * vrat [ ((int) _i ) ]);}
 for (_i=0; _i < 4; _i++) { _p[_dlist1[_i + 12]] /= ( diam * diam * vrat [ ((int) _i ) ]);}
 for (_i=0; _i < 4; _i++) { _p[_dlist1[_i + 16]] /= ( diam * diam * vrat [ ((int) _i ) ]);}
   } return _reset;
 }
 
/*CVODE matsol*/
 static int _ode_matsol1() {_reset=0;{
 double b_flux, f_flux, _term; int _i;
   b_flux = f_flux = 0.;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<28;_i++){
  	_RHS1(_i) = _dt1*(_p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 0) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 0, _i + 0) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 4) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 4, _i + 4) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 8) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 8, _i + 8) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 12) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 12, _i + 12) *= ( diam * diam * vrat [ ((int) _i ) ]);  } 
for (_i=0; _i < 4; _i++) {
  	_RHS1(_i + 16) *= ( diam * diam * vrat [ ((int) _i ) ]) ;
_MATELM1(_i + 16, _i + 16) *= ( diam * diam * vrat [ ((int) _i ) ]);  } }
 /* COMPARTMENT _li , diam * diam * vrat [ ((int) _i ) ] {
 ca bufs cabufs bufm cabufm }
 */
 /* COMPARTMENT volo {
 }
 */
 /* LONGITUDINAL_DIFFUSION _li , DCa * diam * diam * vrat [ ((int) _i ) ] {
 ca }
 */
 /* LONGITUDINAL_DIFFUSION _li , DBufm * diam * diam * vrat [ ((int) _i ) ] {
 bufm cabufm }
 */
 /* ~ ca [ 0 ] <-> sump ( ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) , ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) )*/
 _term =  ( 0.001 ) * parea * gamma * u ( _threadargscomma_ ca [ 0 ] / ( 1.0 ) , cath / ( 1.0 ) ) ;
 _MATELM1( 16 +  0 ,16 +  0)  += _term;
 /* ~ ca [ 0 ] < < ( - ( ica - ica_pmp_last ) * PI * diam / ( 2.0 * FARADAY ) )*/
 /*FLUX*/
  {int  _li ;for ( _li = 0 ; _li <= 4 - 2 ; _li ++ ) {
 /* ~ ca [ _li ] <-> ca [ _li + 1 ] ( DCa * _zfrat [ _li + 1 ] , DCa * _zfrat [ _li + 1 ] )*/
 _term =  DCa * _zfrat [ _li + 1 ] ;
 _MATELM1( 16 +  _li ,16 +  _li)  += _term;
 _MATELM1( 16 +  _li + 1 ,16 +  _li)  -= _term;
 _term =  DCa * _zfrat [ _li + 1 ] ;
 _MATELM1( 16 +  _li ,16 +  _li + 1)  -= _term;
 _MATELM1( 16 +  _li + 1 ,16 +  _li + 1)  += _term;
 /*REACTION*/
  /* ~ bufm [ _li ] <-> bufm [ _li + 1 ] ( DBufm * _zfrat [ _li + 1 ] , DBufm * _zfrat [ _li + 1 ] )*/
 _term =  DBufm * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li)  += _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li)  -= _term;
 _term =  DBufm * _zfrat [ _li + 1 ] ;
 _MATELM1( 0 +  _li ,0 +  _li + 1)  -= _term;
 _MATELM1( 0 +  _li + 1 ,0 +  _li + 1)  += _term;
 /*REACTION*/
  } }
 _zdsq = diam * diam ;
 {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
 _zdsqvol = _zdsq * vrat [ _li ] ;
 /* ~ ca [ _li ] + bufs [ _li ] <-> cabufs [ _li ] ( kfs * _zdsqvol , ( 0.001 ) * KDs * kfs * _zdsqvol )*/
 _term =  kfs * _zdsqvol * ca [ _li] ;
 _MATELM1( 4 +  _li ,4 +  _li)  += _term;
 _MATELM1( 16 +  _li ,4 +  _li)  += _term;
 _MATELM1( 12 +  _li ,4 +  _li)  -= _term;
 _term =  kfs * _zdsqvol * bufs [ _li] ;
 _MATELM1( 4 +  _li ,16 +  _li)  += _term;
 _MATELM1( 16 +  _li ,16 +  _li)  += _term;
 _MATELM1( 12 +  _li ,16 +  _li)  -= _term;
 _term =  ( 0.001 ) * KDs * kfs * _zdsqvol ;
 _MATELM1( 4 +  _li ,12 +  _li)  -= _term;
 _MATELM1( 16 +  _li ,12 +  _li)  -= _term;
 _MATELM1( 12 +  _li ,12 +  _li)  += _term;
 /*REACTION*/
  /* ~ ca [ _li ] + bufm [ _li ] <-> cabufm [ _li ] ( kfm * _zdsqvol , ( 0.001 ) * KDm * kfm * _zdsqvol )*/
 _term =  kfm * _zdsqvol * ca [ _li] ;
 _MATELM1( 0 +  _li ,0 +  _li)  += _term;
 _MATELM1( 16 +  _li ,0 +  _li)  += _term;
 _MATELM1( 8 +  _li ,0 +  _li)  -= _term;
 _term =  kfm * _zdsqvol * bufm [ _li] ;
 _MATELM1( 0 +  _li ,16 +  _li)  += _term;
 _MATELM1( 16 +  _li ,16 +  _li)  += _term;
 _MATELM1( 8 +  _li ,16 +  _li)  -= _term;
 _term =  ( 0.001 ) * KDm * kfm * _zdsqvol ;
 _MATELM1( 0 +  _li ,8 +  _li)  -= _term;
 _MATELM1( 16 +  _li ,8 +  _li)  -= _term;
 _MATELM1( 8 +  _li ,8 +  _li)  += _term;
 /*REACTION*/
  } }
 {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
 _zdsqvol = _zdsq * vrat [ _li ] ;
 /* ~ ca [ _li ] < < ( - _zdsqvol * alpha * vmax * pow( ca [ _li ] , 2.0 ) / ( pow( ca [ _li ] , 2.0 ) + pow( Kp , 2.0 ) ) )*/
 /*FLUX*/
  /* ~ hc [ _li ] <-> ho [ _li ] ( kon * Kinh , kon * ca [ _li ] )*/
 _term =  kon * Kinh ;
 _MATELM1( 24 +  _li ,24 +  _li)  += _term;
 _MATELM1( 20 +  _li ,24 +  _li)  -= _term;
 _term =  kon * ca [ _li ] ;
 _MATELM1( 24 +  _li ,20 +  _li)  -= _term;
 _MATELM1( 20 +  _li ,20 +  _li)  += _term;
 /*REACTION*/
  /* ~ ca [ _li ] < < ( _zdsqvol * alpha * jmax * ( 1.0 - ( ca [ _li ] / caer ) ) * pow( ( ( ip3i / ( ip3i + Kip3 ) ) * ( ca [ _li ] / ( ca [ _li ] + Kact ) ) * ho [ _li ] ) , 3.0 ) )*/
 /*FLUX*/
  /* ~ ca [ _li ] < < ( _zdsqvol * alpha * L [ _li ] * ( 1.0 - ( ca [ _li ] / caer ) ) )*/
 /*FLUX*/
  } }
 cai = ca [ 0 ] ;
 fluo = cabufm [ 0 ] ;
 fluoNew = ( BufferAlpha * cabufm [ 0 ] + ca [ 0 ] - BufferAlpha * ( TBufm - bufm_0 ) - cai0 ) / ( BufferAlpha * ( TBufm - bufm_0 ) + cai0 ) ;
   } return _reset;
 }
 
/*CVODE end*/
 
static int _ode_count(int _type){ return 28;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  cao = _ion_cao;
  cai = _ion_cai;
  ica = _ion_ica;
  cai = _ion_cai;
  ip3i = _ion_ip3i;
     _ode_spec1 ();
  _ion_cai = cai;
  }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 28; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 static void _ode_synonym(int _cnt, double** _pp, Datum** _ppd) { 
 	int _i; 
	for (_i=0; _i < _cnt; ++_i) {_p = _pp[_i]; _ppvar = _ppd[_i];
 _ion_cai =  ca [ 0 ] ;
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
  cao = _ion_cao;
  cai = _ion_cai;
  ica = _ion_ica;
  cai = _ion_cai;
  ip3i = _ion_ip3i;
 _cvode_sparse(&_cvsparseobj1, 28, _dlist1, _p, _ode_matsol1, &_coef1);
 }}
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_ca_sym, _ppvar, 0, 2);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 1, 1);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 2, 3);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 3, 4);
   nrn_update_ion_pointer(_ip3_sym, _ppvar, 5, 1);
   nrn_update_ion_pointer(_ip3_sym, _ppvar, 6, 4);
 }
 static void* _difspace1;
extern double nrn_nernst_coef();
static double _difcoef1(int _i, double* _p, Datum* _ppvar, double* _pdvol, double* _pdfcdc, Datum* _thread, _NrnThread* _nt) {
   *_pdvol =  diam * diam * vrat [ ((int) _i ) ] ;
 if (_i ==  0) {
  *_pdfcdc = nrn_nernst_coef(_type_ica)*( ( - ( _ion_dicadv  - ica_pmp_last ) * PI * diam / ( 2.0 * FARADAY ) ));
 }else{ *_pdfcdc=0.;}
   return DCa * diam * diam * vrat [ ((int) _i ) ] ;
}
 static void* _difspace2;
extern double nrn_nernst_coef();
static double _difcoef2(int _i, double* _p, Datum* _ppvar, double* _pdvol, double* _pdfcdc, Datum* _thread, _NrnThread* _nt) {
   *_pdvol =  diam * diam * vrat [ ((int) _i ) ] ; *_pdfcdc=0.;
   return DBufm * diam * diam * vrat [ ((int) _i ) ] ;
}
 static void* _difspace3;
extern double nrn_nernst_coef();
static double _difcoef3(int _i, double* _p, Datum* _ppvar, double* _pdvol, double* _pdfcdc, Datum* _thread, _NrnThread* _nt) {
   *_pdvol =  diam * diam * vrat [ ((int) _i ) ] ; *_pdfcdc=0.;
   return DBufm * diam * diam * vrat [ ((int) _i ) ] ;
}
 static void _difusfunc(ldifusfunc2_t _f, _NrnThread* _nt) {int _i;
  for (_i=0; _i < 4; ++_i) (*_f)(_mechtype, _difcoef1, &_difspace1, _i,  5, 46 , _nt);
  for (_i=0; _i < 4; ++_i) (*_f)(_mechtype, _difcoef2, &_difspace2, _i,  17, 58 , _nt);
  for (_i=0; _i < 4; ++_i) (*_f)(_mechtype, _difcoef3, &_difspace3, _i,  21, 62 , _nt);
 }

static void initmodel() {
  int _i; double _save;_ninits++;
 _save = t;
 t = 0.0;
{
 for (_i=0; _i<4; _i++) bufm[_i] = bufm0;
 for (_i=0; _i<4; _i++) bufs[_i] = bufs0;
 for (_i=0; _i<4; _i++) cabufm[_i] = cabufm0;
 for (_i=0; _i<4; _i++) cabufs[_i] = cabufs0;
 for (_i=0; _i<4; _i++) ca[_i] = ca0;
 for (_i=0; _i<4; _i++) ho[_i] = ho0;
 for (_i=0; _i<4; _i++) hc[_i] = hc0;
 {
   if ( _zfactors_done  == 0.0 ) {
     _zfactors_done = 1.0 ;
     factors ( _threadargs_ ) ;
     }
   cai = cai0 ;
   bufs_0 = KDs * TBufs / ( KDs + ( 1000.0 ) * cai0 ) ;
   bufm_0 = KDm * TBufm / ( KDm + ( 1000.0 ) * cai0 ) ;
   {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
     ca [ _li ] = cai ;
     bufs [ _li ] = bufs_0 ;
     cabufs [ _li ] = TBufs - bufs_0 ;
     bufm [ _li ] = bufm_0 ;
     cabufm [ _li ] = TBufm - bufm_0 ;
     } }
   sump = cath ;
   parea = PI * diam ;
   ica = 0.0 ;
   ica_pmp = 0.0 ;
   ica_pmp_last = 0.0 ;
   {int  _li ;for ( _li = 0 ; _li <= 4 - 1 ; _li ++ ) {
     ho [ _li ] = Kinh / ( ca [ _li ] + Kinh ) ;
     hc [ _li ] = 1.0 - ho [ _li ] ;
     _zjx = ( - vmax * pow( ca [ _li ] , 2.0 ) / ( pow( ca [ _li ] , 2.0 ) + pow( Kp , 2.0 ) ) ) ;
     _zjx = _zjx + jmax * ( 1.0 - ( ca [ _li ] / caer ) ) * pow( ( ( ip3i / ( ip3i + Kip3 ) ) * ( ca [ _li ] / ( ca [ _li ] + Kact ) ) * ho [ _li ] ) , 3.0 ) ;
     L [ _li ] = - _zjx / ( 1.0 - ( ca [ _li ] / caer ) ) ;
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
  cao = _ion_cao;
  cai = _ion_cai;
  ica = _ion_ica;
  cai = _ion_cai;
  ip3i = _ion_ip3i;
 initmodel();
  _ion_cai = cai;
   nrn_wrote_conc(_ca_sym, (&(_ion_cai)) - 1, _style_ca);
}}

static double _nrn_current(double _v){double _current=0.;v=_v;{ {
   ica_pmp_last = ica_pmp ;
   ica = ica_pmp ;
   }
 _current += ica;

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
  cao = _ion_cao;
  cai = _ion_cai;
  ica = _ion_ica;
  cai = _ion_cai;
  ip3i = _ion_ip3i;
if (_nt->_vcv) { _ode_spec1(); }
 _g = _nrn_current(_v + .001);
 	{ double _dica;
  _dica = ica;
 _rhs = _nrn_current(_v);
  _ion_dicadv += (_dica - ica)/.001 ;
 	}
 _g = (_g - _rhs)/.001;
  _ion_cai = cai;
  _ion_ica += ica ;
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
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
  cao = _ion_cao;
  cai = _ion_cai;
  ica = _ion_ica;
  cai = _ion_cai;
  ip3i = _ion_ip3i;
 { {
 for (; t < _break; t += dt) {
 error = sparse(&_sparseobj1, 28, _slist1, _dlist1, _p, &t, dt, state,&_coef1, _linmat1);
 if(error){fprintf(stderr,"at line 196 in file cadifus.mod:\n    SOLVE state METHOD sparse\n"); nrn_complain(_p); abort_run(error);}
 
}}
 t = _save;
 }  _ion_cai = cai;
 }}

}

static void terminal(){}

static void _initlists() {
 int _i; static int _first = 1;
  if (!_first) return;
 for(_i=0;_i<4;_i++){_slist1[0+_i] = (bufm + _i) - _p;  _dlist1[0+_i] = (Dbufm + _i) - _p;}
 for(_i=0;_i<4;_i++){_slist1[4+_i] = (bufs + _i) - _p;  _dlist1[4+_i] = (Dbufs + _i) - _p;}
 for(_i=0;_i<4;_i++){_slist1[8+_i] = (cabufm + _i) - _p;  _dlist1[8+_i] = (Dcabufm + _i) - _p;}
 for(_i=0;_i<4;_i++){_slist1[12+_i] = (cabufs + _i) - _p;  _dlist1[12+_i] = (Dcabufs + _i) - _p;}
 for(_i=0;_i<4;_i++){_slist1[16+_i] = (ca + _i) - _p;  _dlist1[16+_i] = (Dca + _i) - _p;}
 for(_i=0;_i<4;_i++){_slist1[20+_i] = (ho + _i) - _p;  _dlist1[20+_i] = (Dho + _i) - _p;}
 for(_i=0;_i<4;_i++){_slist1[24+_i] = (hc + _i) - _p;  _dlist1[24+_i] = (Dhc + _i) - _p;}
_first = 0;
}
