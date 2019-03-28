#delimit ;
set more 1;

/* stats.do computes statistics from the cleaned dataset in 'build/output' */

clear;
use ${build}/output/NLSY_cleaned.dta;

/* -----------------------------------------------------------------------------
RESHAPE WIDE
-----------------------------------------------------------------------------*/;

global longvars 	age
					hhsize 
					highgrade 
					highdegr 
					piat
					income
					children
					health
					feet
					inches
					weight
					cumwt
					panwt
					hhincome
					hhincsource
					hours
					lim_kindwork
					lim_amountwork
					occupation
					urban
					cregion
					workwks
					married
					siblings
					inctopcode
					hhinctopcode
					height
					incomerate
					lincomerate
					lincome
					evermarried
					div_sep;

quietly reshape wide ${longvars}, i(id) j(year);

/* -----------------------------------------------------------------------------
SAMPLE SELECTION
-----------------------------------------------------------------------------*/;

keep if hours2014 >= 1000;
keep if lincomerate2014 >= 0;
keep if race == 4; // non-black and non-hispanic;

/* -----------------------------------------------------------------------------
SUMMARY STATISTICS
-----------------------------------------------------------------------------*/;
do ${stats}/code/stats1_summarytables.do;


/* -----------------------------------------------------------------------------
REGRESSIONS
-----------------------------------------------------------------------------*/;
global heightvar continuous;
do ${stats}/code/stats2_regressions.do;
global heightvar quartiles;
do ${stats}/code/stats2_regressions.do;

/* -----------------------------------------------------------------------------
SCATTER PLOTS
-----------------------------------------------------------------------------*/;
do ${stats}/code/stats3_scatter.do;
