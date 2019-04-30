NEURON {
    THREADSAFE
    SUFFIX reporter
	USEION ca READ cai
	USEION ip3 READ ip3i VALENCE 1 
}
    
PARAMETER {
    period = 100 (ms)   : Interval between reports
}
ASSIGNED {
cai       (mM)
ip3i (mM)
}

BREAKPOINT {
    VERBATIM
        static double lastReportTime;
        if (fmod(t, period) == 0 && t > lastReportTime)
        {
            printf("time: %g ms\n", t);	
            printf("cai_Soma: %g mM\n", cai);				
			printf("ip3i_Soma: %g mM\n", ip3i);				
        }
		
        lastReportTime = t;
    ENDVERBATIM
}