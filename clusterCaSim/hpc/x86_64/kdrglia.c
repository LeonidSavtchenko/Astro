/* Created by Language version: 6.2.0 */
/* VECTORIZED */
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
 
#if METHOD3
extern int _method3;
#endif

#if !NRNGPU
#undef exp
#define exp hoc_Exp
extern double hoc_Exp(double);
#endif
 
#define _threadargscomma_ _p, _ppvar, _thread, _nt,
#define _threadargs_ _p, _ppvar, _thread, _nt
 
#define _threadargsprotocomma_ double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt,
#define _threadargsproto_ double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 /* Thread safe. No static _p or _ppvar. */
 
#define t _nt->_t
#define dt _nt->_dt
#define gkbar _p[0]
#define ik _p[1]
#define gk _p[2]
#define n _p[3]
#define c _p[4]
#define qk _p[5]
#define ek _p[6]
#define Dn _p[7]
#define Dc _p[8]
#define Dqk _p[9]
#define v _p[10]
#define _g _p[11]
#define _ion_ek	*_ppvar[0]._pval
#define _ion_ik	*_ppvar[1]._pval
#define _ion_dikdv	*_ppvar[2]._pval
#define diam	*_ppvar[3]._pval
 
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
 static Datum* _extcall_thread;
 static Prop* _extcall_prop;
 /* external NEURON variables */
 /* declaration of user functions */
 static void _hoc_a_c(void);
 static void _hoc_a_n(void);
 static void _hoc_n_inf(void);
 static void _hoc_window(void);
 static int _mechtype;
extern void _nrn_cacheloop_reg(int, int);
extern void hoc_register_prop_size(int, int, int);
extern void hoc_register_limits(int, HocParmLimits*);
extern void hoc_register_units(int, HocParmUnits*);
extern void nrn_promote(Prop*, int, int);
extern Memb_func* memb_func;
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _extcall_prop = _prop;
 }
 static void _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range(int);
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 hoc_retpushx(1.);
}
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 "setdata_kdrglia", _hoc_setdata,
 "a_c_kdrglia", _hoc_a_c,
 "a_n_kdrglia", _hoc_a_n,
 "n_inf_kdrglia", _hoc_n_inf,
 "window_kdrglia", _hoc_window,
 0, 0
};
#define _f_a_c _f_a_c_kdrglia
#define _f_a_n _f_a_n_kdrglia
#define a_c a_c_kdrglia
#define a_n a_n_kdrglia
#define n_inf n_inf_kdrglia
#define window window_kdrglia
 extern double _f_a_c( _threadargsprotocomma_ double );
 extern double _f_a_n( _threadargsprotocomma_ double );
 extern double a_c( _threadargsprotocomma_ double );
 extern double a_n( _threadargsprotocomma_ double );
 extern double n_inf( _threadargsprotocomma_ double );
 extern double window( _threadargsprotocomma_ double );
 
static void _check_a_n(double*, Datum*, Datum*, _NrnThread*); 
static void _check_a_c(double*, Datum*, Datum*, _NrnThread*); 
static void _check_table_thread(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, int _type) {
   _check_a_n(_p, _ppvar, _thread, _nt);
   _check_a_c(_p, _ppvar, _thread, _nt);
 }
 #define _za1 _thread[2]._pval[0]
 #define _za2 _thread[2]._pval[1]
 /* declare global and static user variables */
#define shiftn shiftn_kdrglia
 double shiftn = 50;
#define scaletaun scaletaun_kdrglia
 double scaletaun = 1.5;
#define usetable usetable_kdrglia
 double usetable = 1;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 "usetable_kdrglia", 0, 1,
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "shiftn_kdrglia", "mV",
 "gkbar_kdrglia", "mho/cm2",
 "ik_kdrglia", "mA/cm2",
 "gk_kdrglia", "S/cm2",
 0,0
};
 static double c0 = 0;
 static double delta_t = 0.01;
 static double n0 = 0;
 static double qk0 = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "scaletaun_kdrglia", &scaletaun_kdrglia,
 "shiftn_kdrglia", &shiftn_kdrglia,
 "usetable_kdrglia", &usetable_kdrglia,
 0,0
};
 static DoubVec hoc_vdoub[] = {
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
 
#define _cvode_ieq _ppvar[4]._i
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "6.2.0",
"kdrglia",
 "gkbar_kdrglia",
 0,
 "ik_kdrglia",
 "gk_kdrglia",
 0,
 "n_kdrglia",
 "c_kdrglia",
 "qk_kdrglia",
 0,
 0};
 static Symbol* _morphology_sym;
 static Symbol* _k_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 12, _prop);
 	/*initialize range parameters*/
 	gkbar = 0;
 	_prop->param = _p;
 	_prop->param_size = 12;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 5, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_morphology_sym);
 	_ppvar[3]._pval = &prop_ion->param[0]; /* diam */
 prop_ion = need_memb(_k_sym);
 nrn_promote(prop_ion, 0, 1);
 	_ppvar[0]._pval = &prop_ion->param[0]; /* ek */
 	_ppvar[1]._pval = &prop_ion->param[3]; /* ik */
 	_ppvar[2]._pval = &prop_ion->param[4]; /* _ion_dikdv */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _thread_mem_init(Datum*);
 static void _thread_cleanup(Datum*);
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*f)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _kdrglia_reg() {
	int _vectorized = 1;
  _initlists();
 	ion_reg("k", -10000.);
 	_morphology_sym = hoc_lookup("morphology");
 	_k_sym = hoc_lookup("k_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 4);
  _extcall_thread = (Datum*)ecalloc(3, sizeof(Datum));
  _thread_mem_init(_extcall_thread);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 1, _thread_mem_init);
     _nrn_thread_reg(_mechtype, 0, _thread_cleanup);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
     _nrn_thread_table_reg(_mechtype, _check_table_thread);
  hoc_register_prop_size(_mechtype, 12, 5);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 kdrglia /home/savtchenko/amcbridge/phase14/nano/clusterCaSim/hpc/x86_64/kdrglia.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
 static double FARADAY = 96485.309;
 static double R = 8.31342;
 static double PI = 3.14159;
 /*Top LOCAL _za1 , _za2 */
 static double *_t_a_n;
 static double *_t_a_c;
static int _reset;
static char *modelname = "kdrglia";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
 extern double *_nrn_thread_getelm();
 
#define _MATELM1(_row,_col) *(_nrn_thread_getelm(_so, _row + 1, _col + 1))
 
#define _RHS1(_arg) _rhs[_arg+1]
  
#define _linmat1  1
 static int _spth1 = 1;
 static int _cvspth1 = 0;
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static double _n_a_c(_threadargsprotocomma_ double _lv);
 static double _n_a_n(_threadargsprotocomma_ double _lv);
 static int _slist1[3], _dlist1[3]; static double *_temp1;
 static int kstate();
 
static int kstate (void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt)
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<3;_i++){
  	_RHS1(_i) = -_dt1*(_p[_slist1[_i]] - _p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
}  
_RHS1(2) *= ( diam * diam * PI / 4.0) ;
_MATELM1(2, 2) *= ( diam * diam * PI / 4.0);  }
 _za1 = a_n ( _threadargscomma_ v ) ;
   _za2 = a_c ( _threadargscomma_ v ) ;
   /* ~ c <-> n ( _za1 , _za2 )*/
 f_flux =  _za1 * c ;
 b_flux =  _za2 * n ;
 _RHS1( 1) += (f_flux - b_flux);
 
 _term =  _za1 ;
 _MATELM1( 1 ,0)  -= _term;
 _term =  _za2 ;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
   /* n + c = 1.0 */
 _RHS1(0) =  1.0;
 _MATELM1(0, 0) = 1;
 _RHS1(0) -= c ;
 _MATELM1(0, 1) = 1;
 _RHS1(0) -= n ;
 /*CONSERVATION*/
 /* COMPARTMENT diam * diam * PI / 4.0 {
     qk }
   */
 /* ~ qk < < ( - ik * diam * PI * ( 1e4 ) / FARADAY )*/
 f_flux = b_flux = 0.;
 _RHS1( 2) += (b_flux =   ( - ik * diam * PI * ( 1e4 ) / FARADAY ) );
 /*FLUX*/
    } return _reset;
 }
 static double _mfac_a_n, _tmin_a_n;
  static void _check_a_n(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  static int _maktable=1; int _i, _j, _ix = 0;
  double _xi, _tmax;
  static double _sav_scaletaun;
  static double _sav_shiftn;
  if (!usetable) {return;}
  if (_sav_scaletaun != scaletaun) { _maktable = 1;}
  if (_sav_shiftn != shiftn) { _maktable = 1;}
  if (_maktable) { double _x, _dx; _maktable=0;
   _tmin_a_n =  - 150.0 ;
   _tmax =  150.0 ;
   _dx = (_tmax - _tmin_a_n)/200.; _mfac_a_n = 1./_dx;
   for (_i=0, _x=_tmin_a_n; _i < 201; _x += _dx, _i++) {
    _t_a_n[_i] = _f_a_n(_p, _ppvar, _thread, _nt, _x);
   }
   _sav_scaletaun = scaletaun;
   _sav_shiftn = shiftn;
  }
 }

 double a_n(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _lv) { 
#if 0
_check_a_n(_p, _ppvar, _thread, _nt);
#endif
 return _n_a_n(_p, _ppvar, _thread, _nt, _lv);
 }

 static double _n_a_n(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _lv){ int _i, _j;
 double _xi, _theta;
 if (!usetable) {
 return _f_a_n(_p, _ppvar, _thread, _nt, _lv); 
}
 _xi = _mfac_a_n * (_lv - _tmin_a_n);
 if (isnan(_xi)) {
  return _xi; }
 if (_xi <= 0.) {
 return _t_a_n[0];
 }
 if (_xi >= 200.) {
 return _t_a_n[200];
 }
 _i = (int) _xi;
 return _t_a_n[_i] + (_xi - (double)_i)*(_t_a_n[_i+1] - _t_a_n[_i]);
 }

 
double _f_a_n ( _threadargsprotocomma_ double _lv ) {
   double _la_n;
 _la_n = scaletaun * 0.016 * ( 35.1 - _lv - shiftn - 70.0 ) / ( exp ( ( 35.1 - _lv - shiftn - 70.0 ) / 5.0 ) - 1.0 ) ;
   
return _la_n;
 }
 
static void _hoc_a_n(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 
#if 1
 _check_a_n(_p, _ppvar, _thread, _nt);
#endif
 _r =  a_n ( _p, _ppvar, _thread, _nt, *getarg(1) );
 hoc_retpushx(_r);
}
 static double _mfac_a_c, _tmin_a_c;
  static void _check_a_c(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  static int _maktable=1; int _i, _j, _ix = 0;
  double _xi, _tmax;
  static double _sav_scaletaun;
  static double _sav_shiftn;
  if (!usetable) {return;}
  if (_sav_scaletaun != scaletaun) { _maktable = 1;}
  if (_sav_shiftn != shiftn) { _maktable = 1;}
  if (_maktable) { double _x, _dx; _maktable=0;
   _tmin_a_c =  - 150.0 ;
   _tmax =  150.0 ;
   _dx = (_tmax - _tmin_a_c)/200.; _mfac_a_c = 1./_dx;
   for (_i=0, _x=_tmin_a_c; _i < 201; _x += _dx, _i++) {
    _t_a_c[_i] = _f_a_c(_p, _ppvar, _thread, _nt, _x);
   }
   _sav_scaletaun = scaletaun;
   _sav_shiftn = shiftn;
  }
 }

 double a_c(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _lv) { 
#if 0
_check_a_c(_p, _ppvar, _thread, _nt);
#endif
 return _n_a_c(_p, _ppvar, _thread, _nt, _lv);
 }

 static double _n_a_c(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _lv){ int _i, _j;
 double _xi, _theta;
 if (!usetable) {
 return _f_a_c(_p, _ppvar, _thread, _nt, _lv); 
}
 _xi = _mfac_a_c * (_lv - _tmin_a_c);
 if (isnan(_xi)) {
  return _xi; }
 if (_xi <= 0.) {
 return _t_a_c[0];
 }
 if (_xi >= 200.) {
 return _t_a_c[200];
 }
 _i = (int) _xi;
 return _t_a_c[_i] + (_xi - (double)_i)*(_t_a_c[_i+1] - _t_a_c[_i]);
 }

 
double _f_a_c ( _threadargsprotocomma_ double _lv ) {
   double _la_c;
 _la_c = scaletaun * 0.25 * exp ( ( 20.0 - _lv - shiftn - 70.0 ) / 40.0 ) ;
   
return _la_c;
 }
 
static void _hoc_a_c(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 
#if 1
 _check_a_c(_p, _ppvar, _thread, _nt);
#endif
 _r =  a_c ( _p, _ppvar, _thread, _nt, *getarg(1) );
 hoc_retpushx(_r);
}
 
double n_inf ( _threadargsprotocomma_ double _lv ) {
   double _ln_inf;
 _ln_inf = a_n ( _threadargscomma_ _lv ) / ( a_n ( _threadargscomma_ _lv ) + a_c ( _threadargscomma_ _lv ) ) ;
   
return _ln_inf;
 }
 
static void _hoc_n_inf(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  n_inf ( _p, _ppvar, _thread, _nt, *getarg(1) );
 hoc_retpushx(_r);
}
 
double window ( _threadargsprotocomma_ double _lv ) {
   double _lwindow;
 _lwindow = gkbar * pow( n_inf ( _threadargscomma_ _lv ) , 4.0 ) * ( _lv - ek ) ;
   
return _lwindow;
 }
 
static void _hoc_window(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  window ( _p, _ppvar, _thread, _nt, *getarg(1) );
 hoc_retpushx(_r);
}
 
/*CVODE ode begin*/
 static int _ode_spec1(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<3;_i++) _p[_dlist1[_i]] = 0.0;}
 _za1 = a_n ( _threadargscomma_ v ) ;
 _za2 = a_c ( _threadargscomma_ v ) ;
 /* ~ c <-> n ( _za1 , _za2 )*/
 f_flux =  _za1 * c ;
 b_flux =  _za2 * n ;
 Dc -= (f_flux - b_flux);
 Dn += (f_flux - b_flux);
 
 /*REACTION*/
   /* n + c = 1.0 */
 /*CONSERVATION*/
 /* COMPARTMENT diam * diam * PI / 4.0 {
   qk }
 */
 /* ~ qk < < ( - ik * diam * PI * ( 1e4 ) / FARADAY )*/
 f_flux = b_flux = 0.;
 Dqk += (b_flux =   ( - ik * diam * PI * ( 1e4 ) / FARADAY ) );
 /*FLUX*/
  _p[_dlist1[2]] /= ( diam * diam * PI / 4.0);
   } return _reset;
 }
 
/*CVODE matsol*/
 static int _ode_matsol1(void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
   b_flux = f_flux = 0.;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<3;_i++){
  	_RHS1(_i) = _dt1*(_p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
}  
_RHS1(2) *= ( diam * diam * PI / 4.0) ;
_MATELM1(2, 2) *= ( diam * diam * PI / 4.0);  }
 _za1 = a_n ( _threadargscomma_ v ) ;
 _za2 = a_c ( _threadargscomma_ v ) ;
 /* ~ c <-> n ( _za1 , _za2 )*/
 _term =  _za1 ;
 _MATELM1( 0 ,0)  += _term;
 _MATELM1( 1 ,0)  -= _term;
 _term =  _za2 ;
 _MATELM1( 0 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
   /* n + c = 1.0 */
 /*CONSERVATION*/
 /* COMPARTMENT diam * diam * PI / 4.0 {
 qk }
 */
 /* ~ qk < < ( - ik * diam * PI * ( 1e4 ) / FARADAY )*/
 /*FLUX*/
    } return _reset;
 }
 
/*CVODE end*/
 
static int _ode_count(int _type){ return 3;}
 
static void _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ek = _ion_ek;
     _ode_spec1 (_p, _ppvar, _thread, _nt);
  }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 3; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 
static void _ode_matsol(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ek = _ion_ek;
 _cvode_sparse_thread(&_thread[_cvspth1]._pvoid, 3, _dlist1, _p, _ode_matsol1, _ppvar, _thread, _nt);
 }}
 
static void _thread_mem_init(Datum* _thread) {
   _thread[2]._pval = (double*)ecalloc(2, sizeof(double));
 }
 
static void _thread_cleanup(Datum* _thread) {
   _nrn_destroy_sparseobj_thread(_thread[_cvspth1]._pvoid);
   _nrn_destroy_sparseobj_thread(_thread[_spth1]._pvoid);
   free((void*)(_thread[2]._pval));
 }
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_k_sym, _ppvar, 0, 0);
   nrn_update_ion_pointer(_k_sym, _ppvar, 1, 3);
   nrn_update_ion_pointer(_k_sym, _ppvar, 2, 4);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  int _i; double _save;{
  c = c0;
  n = n0;
  qk = qk0;
 {
   n = n_inf ( _threadargscomma_ v ) ;
   c = 1.0 - n ;
   gk = gkbar * n * n * n * n ;
   ik = gk * ( v - ek ) ;
   qk = 0.0 ;
   }
 
}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];

#if 0
 _check_a_n(_p, _ppvar, _thread, _nt);
 _check_a_c(_p, _ppvar, _thread, _nt);
#endif
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
  ek = _ion_ek;
 initmodel(_p, _ppvar, _thread, _nt);
 }}

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _v){double _current=0.;v=_v;{ {
   gk = gkbar * n * n * n * n ;
   ik = gk * ( v - ek ) ;
   }
 _current += ik;

} return _current;
}

static void nrn_cur(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
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
  ek = _ion_ek;
 _g = _nrn_current(_p, _ppvar, _thread, _nt, _v + .001);
 	{ double _dik;
  _dik = ik;
 _rhs = _nrn_current(_p, _ppvar, _thread, _nt, _v);
  _ion_dikdv += (_dik - ik)/.001 ;
 	}
 _g = (_g - _rhs)/.001;
  _ion_ik += ik ;
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
  }
 
}}

static void nrn_jacob(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
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

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type) {
 double _break, _save;
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
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
  ek = _ion_ek;
 { {
 for (; t < _break; t += dt) {
  sparse_thread(&_thread[_spth1]._pvoid, 3, _slist1, _dlist1, _p, &t, dt, kstate, _linmat1, _ppvar, _thread, _nt);
  
}}
 t = _save;
 } }}

}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
   _t_a_n = makevector(201*sizeof(double));
   _t_a_c = makevector(201*sizeof(double));
 _slist1[0] = &(c) - _p;  _dlist1[0] = &(Dc) - _p;
 _slist1[1] = &(n) - _p;  _dlist1[1] = &(Dn) - _p;
 _slist1[2] = &(qk) - _p;  _dlist1[2] = &(Dqk) - _p;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif
