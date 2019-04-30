NEURON {
    THREADSAFE
    SUFFIX IP3Time
	USEION ip3 READ ip3i WRITE ip3i VALENCE 1 
}
    
PARAMETER {
    : period = 100 (ms)   : Interval between reports
	 TDelay = 500 (ms)
	 DurationIP3i = 1000 (ms)
	 ip3io = 0.01 (mM)
	 BasicIP3 = 0.0001 (mM)
	
}
ASSIGNED {
  ip3i       (mM)
}

INITIAL {
  ip3i=0.000001 (mM)
}
BREAKPOINT {
    VERBATIM
      
       if ((t > TDelay ) && (t < TDelay + DurationIP3i ))
        {
            ip3i=ip3io;
        } else {
		ip3i=BasicIP3; 
		}
		 
    ENDVERBATIM
}