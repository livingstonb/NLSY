#delimit ;

/* stats.do computes statistics from the cleaned dataset in 'build/output' */

clear;
use ${build}/output/NLSY_cleaned.dta;

/* -----------------------------------------------------------------------------
SAMPLE SELECTION
-----------------------------------------------------------------------------*/;

keep if hours >= 30;
keep if sex == 1; // male only for now;
keep if race == 4; // non-black and non-hispanic;

/* -----------------------------------------------------------------------------
SUMMARY STATISTICS
-----------------------------------------------------------------------------*/;
do ${stats}/code/stats1_summary.do;


/* -----------------------------------------------------------------------------
PRELIMINARY REGRESSIONS
-----------------------------------------------------------------------------*/;
do ${stats}/code/stats2_prelimOLS.do;


