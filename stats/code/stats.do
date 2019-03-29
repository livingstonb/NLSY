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

keep if hours2014 >= 1000 & !missing(hours2014);
keep if lincomerate2014 >= 0 & !missing(lincomerate2014);
keep if race == 4; // non-black and non-hispanic;
keep if height2011 >= 50 & !missing(height2011); // throw out two outliers;

sort sex height2011;

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
foreach inc in hourly annual {;
	// create plots for both hourly and annual income variables;
	global incvar `inc';
	
	foreach res in none fedminwage {;
		global restriction `res';
		global scale normal;
		global fit linear;
	
		// create scatter plots;
		do ${stats}/code/stats3_scatter.do;
	};
	
	foreach sc in normal narrow {;
		global restriction none;
		global scale `sc';
		global fit linear;
		
		// create scatter plots;
		do ${stats}/code/stats3_scatter.do;
	};
	
	foreach ft in linear quadr fpoly {;
		global restriction none;
		global scale normal;
		global fit `ft';
		
		// create scatter plots;
		do ${stats}/code/stats3_scatter.do;
	};
};
