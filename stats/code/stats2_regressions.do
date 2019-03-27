#delimit ;
set more 1;

/* OLS estimation of regressions */;

local coeffs 	height1997 "Teen height (in)"
				height2011 "Adult height (in)"
				age2014 "Age in 2014"
				cumhighgrade "Years of completed schooling"
				resmother_highgrade "Mother's years of schooling"
				resfather_highgrade "Father's years of schooling"
				siblings2011 "Number of siblings"
				asvab_score_pct "ASVAB pctile score"
				parentnetworth1997 "1997 HH net worth (millions)"
				lim_kindwork2007 "Health limitations in kind of work, 2007"
				lim_amountwork2007 "Health limitations in amount of work, 2007"
				weight1997 "Weight in 1997, lbs"
				weight2013 "Weight in 2013, lbs";

foreach gender in pooled men women {;

	if "`gender'" == "men" {;
		local cond "(sex == 1)";
	};
	else if "`gender'" == "women" {;
		local cond "(sex == 2)";
	};
	else {;
		local cond "(sex == 1) | (sex == 2)";
	};

/* -----------------------------------------------------------------------------
CONTROLLING FOR FAMILY CHARACTERISTICS
-----------------------------------------------------------------------------*/;

	estimates clear;
	eststo: quietly reg lincomerate2014 height2011 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 asvab_score_pct if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 age2014 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 
						resmother_highgrade resfather_highgrade
						siblings2011 parentnetworth1997 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 
						resmother_highgrade resfather_highgrade
						siblings2011 parentnetworth1997 age2014 
						asvab_score_pct if `cond', robust;

	esttab using ${stats}/output/regressions/OLSfamily_`gender'.tex,
		replace
		se
		ar2
		nomtitles
		noconst
		title("Effect on 2014 log hourly wage with family controls, `gender'")
		nonotes
		addnotes(	"Heteroskedasticity-robust standard errors in parentheses"
					"* p $<$ 0.05, ** p $<$ 0.01, *** p $<$ 0.001")
		coeflabels(`coeffs');

/* -----------------------------------------------------------------------------
CONTROLLING FOR FAMILY CHARACTERISTICS AND TEEN HEIGHT
-----------------------------------------------------------------------------*/;

	estimates clear;
	eststo: quietly reg lincomerate2014 height2011 height1997 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 asvab_score_pct if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 age2014 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 
		resmother_highgrade resfather_highgrade
		siblings2011 parentnetworth1997 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 
		resmother_highgrade resfather_highgrade
		siblings2011 parentnetworth1997 age2014 asvab_score_pct if `cond', robust;

	esttab using ${stats}/output/regressions/OLSfamily_teenheight_`gender'.tex,
		replace
		se
		ar2
		nomtitles
		noconst
		title("Effect on 2014 log hourly wage with family controls and teen height, `gender'")
		nonotes
		addnotes(	"Heteroskedasticity-robust standard errors in parentheses"
					"* p $<$ 0.05, ** p $<$ 0.01, *** p $<$ 0.001")
		coeflabels(`coeffs');

/* -----------------------------------------------------------------------------
CONTROLLING FOR HEALTH
-----------------------------------------------------------------------------*/;

	estimates clear;
	eststo: quietly reg lincomerate2014 height2011 height1997 age2014 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 age2014
						lim_kindwork2007 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 age2014
						lim_amountwork2007 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 age2014
						lim_kindwork2007 lim_amountwork2007 if `cond', robust;
	eststo: quietly reg lincomerate2014 height2011 height1997 age2014
						weight1997 weight2013 if `cond', robust;
						
	esttab using ${stats}/output/regressions/OLShealth_`gender'.tex,
		replace
		se
		ar2
		nomtitles
		noconst
		title("Effect on 2014 log hourly wage with health controls, `gender'")
		nonotes
		addnotes(	"Heteroskedasticity-robust standard errors in parentheses"
					"* p $<$ 0.05, ** p $<$ 0.01, *** p $<$ 0.001")
		coeflabels(`coeffs');
};