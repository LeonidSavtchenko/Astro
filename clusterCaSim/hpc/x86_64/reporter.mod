NEURON {
    THREADSAFE
    SUFFIX reporter
}
    
PARAMETER {
    period = 100 (ms)   : Interval between reports
}

BREAKPOINT {
    VERBATIM
        static double lastReportTime;
        if (fmod(t, period) == 0 && t > lastReportTime)
        {
            printf("time: %g ms\n", t);
        }
        lastReportTime = t;
    ENDVERBATIM
}