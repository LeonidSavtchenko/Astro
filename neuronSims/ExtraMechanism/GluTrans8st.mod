


NEURON {
	SUFFIX  GluTrans8st
	RANGE part, C1, C2, C3, C4, C5, C6, C7, C8
	GLOBAL k12, k21, k23, k32, k34, k43, k45, k54, k56, k65, k67, k76, k78, k87, k18, k81
	GLOBAL Nain, Naout, Kin, Kout, Gluin, charge 
    RANGE  itrans, Gluout, density
	NONSPECIFIC_CURRENT itrans
}

UNITS {
	(l) = (liter)
	(nA) = (nanoamp)
	(mV) = (millivolt)
	(mA) = (milliamp)
	(pS) = (picosiemens)
	(umho) = (micromho)
	(mM) = (milli/liter)
	(uM) = (micro/liter)
	F = (faraday) (coulombs)
	PI      = (pi)       (1)
}

PARAMETER {


	
: Rates

k12 = 20           (/ms)
k21 = 1            (l /mM /ms)
k23 = 1.0e-2       (l /mM /ms)
k32 = 0.1          (/ms)
k34 = 6            (l /mM /ms)
k43 = 0.5          (/ms)
k45 = 2            (/ms)
k54 = 1.9          (/ms)
k56 = 1            (/ms) 
k65 = 0.04         (l /mM /ms) 
k67 =100           (/ms)  
k76 = 100          (l /mM /ms)
k78 = 1            (l /mM /ms)
k87 = 1            (/ms) 
k81 = 1.6          (/ms)
k18 =  2e-4        (/ms)

Nain = 8        (mM/l)
Naout = 146.2   (mM/l)
Kin = 155       (mM/l)
Kout = 2        (mM/l)
Gluin = 20      (mM/l)
Gluout = 0.0	(mM/l)
density =5e11  : (/cm2) : 5000 per um2
charge = 1.6e-19 (coulombs)
	
}

COMMENT


ENDCOMMENT


ASSIGNED {
	v	   (mV)		:  voltage
    itrans (mA/cm2)            : 
	surf   (cm2)
	volin  (liter)
	volout (liter)
}

STATE {
	: Transporter  states (all fractions)
			: 
	C1	(/cm2)	:  
	C2	(/cm2)	:  
	C3	(/cm2)	: 
	C4	(/cm2)	: 
	C5	(/cm2)	: 
	C6  (/cm2)
	C7	(/cm2)	: 
	C8  (/cm2)
	
}

INITIAL {
	 Gluout = 0
	 C1 = 0.0090
	 C2 = 0.56056
	 C3 = 0.3111 
	 C4 = 0.1046
	 C5 = 0.0021
	 C6 =  0.0124
	 C7 = 0
	 C8 = 0
	
	
	volin = 1
	volout = 1
	surf = 1	   	
}

BREAKPOINT {	
	  SOLVE kstates METHOD sparse
      
 
 itrans=-charge*density*(1e+006)*(0.46*(C2*k23*u(v,0.46)*Naout-C3*k32) +0.55*(C3*k34*u(v,0.55)*Gluout-C4*k43)+0.4*(C5*k56-C6*k65*Gluin*u(v,0.4)) + 0.59*(C8*u(v,0.59)*k81 - C1*k18))

	  }
 
KINETIC kstates {
	     COMPARTMENT volin { Nain Kin Gluin}
		 COMPARTMENT volout { Naout Kout Gluout}
	     : COMPARTMENT surf { C1 C2 C3 C4 C5 C6 C7 C8}
	    
        ~ C1 <-> C2 + Kout       (k12*surf, k21*surf)		
        ~ C2 + Naout <-> C3      (k23*u(v,0.46)*surf,k32*surf)		
	    ~ C3 + Gluout <-> C4	 (k34*u(v,0.55)*surf,k43*surf)		
	    ~ C4 <-> C5 	         (k45*surf,k54*surf)		
		~ C5 <-> C6	+ Gluin      (k56*surf,k65*u(v,0.4)*surf)
		~ C6 <-> C7 + Nain       (k67*surf,k76*surf)		
		~ C7 <-> C8 +Kin         (k78*surf,k87*surf)		
		~ C8 <-> C1              (k81*u(v,0.59)*surf, k18*surf)
		

		
	CONSERVE C1+C2+C3+C4+C5+C6+C7+C8= 1

		
:	CONSERVE C1+C2= 1
}


FUNCTION u(x(mV), th) {
  
    u = exp(th*x/(2*26.7))
  
}







