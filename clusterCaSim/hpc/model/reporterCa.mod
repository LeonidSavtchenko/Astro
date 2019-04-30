NEURON {
    THREADSAFE
    SUFFIX reporterCa
	USEION ca READ cai
}
    
PARAMETER {
    periodCa = 100 (ms)   : Interval between reports
}
ASSIGNED {
cai       (mM)
}

BREAKPOINT {
    VERBATIM
        static double lastReportTime;
        if (fmod(t, periodCa) == 0 && t > lastReportTime)
        {
           
            printf("cai_dendrite1 %g mM\n", cai);				
        }
		
        lastReportTime = t;
    ENDVERBATIM
}