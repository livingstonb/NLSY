#delimit ;
set more 1;

/* OLS estimation of regressions */;

local coeffs 	height1997 "Teen height (in)"
				height2011 "Adult height (in)"
				htquartile2 "Dummy, 2nd height quartile"
				htquartile3 "Dummy, 3rd height quartile"
				htquartile4 "Dummy, 4th (top) height quartile"
				age2014 "Age in 2014"
				cumhighgrade "Years of completed schooling"
				resmother_highgrade "Mother's years of schooling"
				resfather_highgrade "Father's years of schooling"
				parenthighgrade "Most years of schooling, either parent"
				siblings2011 "Number of siblings"
				asvab_score_pct "ASVAB pctile score"
				parentnetworth1997 "1997 HH net worth (millions)"
				lim_kindwork2007 "Health limitations in kind of work, 2007"
				lim_amountwork2007 "Health limitations in amount of work, 2007"
				weight1997 "Weight in 1997, lbs"
				weight2013 "Weight in 2013, lbs"
				hhsize1998 "1998 Number of HH members"
				male "Male";

foreach tcontrol in th noth {;
	// whether or not to control for teen height;
	if "`tcontrol'" == "th" {;
		local th height1997;
		local thlab " and teen height";
	};
	else if "`tcontrol'" == "noth" {;
		local th;
		local thlab;
	};
foreach gender in pooled men women {;
	if "`gender'" == "men" {;
		local cond "(sex == 1)";
		local gdummy;
	};
	else if "`gender'" == "women" {;
		local cond "(sex == 2)";
		local gdummy;
	};
	else {;
		local cond "(sex == 1) | (sex == 2)";
		local gdummy male;
	};
	
	// height quartile dummies;
	xtile temp = height1997 if `cond', nq(4);
	quietly tab temp, gen(htquartile);
	drop temp;
	
	if "$heightvar" == "continuous" {;
		local adultheight height2011;
		local htype hc;
		local hlab "cont height";
	};
	else if "$heightvar" == "quartiles" {;
		local adultheight htquartile2 htquartile3 htquartile4;
		local htype hq;
		local hlab "height quartiles";
	};

	/* -------------------------------------------------------------------------
	CONTROLLING FOR FAMILY CHARACTERISTICS
	-------------------------------------------------------------------------*/;

	estimates clear;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy'  if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy'  asvab_score_pct if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy'  age2014 if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy'  age2014 asvab_score_pct if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy'  
		parentnetworth1997 if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' 
		parenthighgrade hhsize1998 age2014 asvab_score_pct  if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' 
		parenthighgrade parentnetworth1997 hhsize1998 age2014 asvab_score_pct  if `cond', robust;	
		
	esttab using ${stats}/output/regressions/OLSfamily_`tcontrol'_`htype'_`gender'.tex,
		replace
		se
		ar2
		nomtitles
		noconst
		title("Effect on 2014 log hourly wage with family controls`thlab', `gender', `hlab'")
		nonotes
		addnotes(	"Heteroskedasticity-robust standard errors in parentheses"
					"* p $<$ 0.05, ** p $<$ 0.01, *** p $<$ 0.001")
		coeflabels(`coeffs');

	/* -------------------------------------------------------------------------
	CONTROLLING FOR HEALTH
	-------------------------------------------------------------------------*/;

	estimates clear;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' age2014 if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' age2014
						lim_kindwork2007 if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' age2014
						lim_amountwork2007 if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' age2014
						lim_kindwork2007 lim_amountwork2007 if `cond', robust;
	eststo: quietly reg lincomerate2014 `adultheight' `th' `gdummy' age2014
						weight1997 weight2013 if `cond', robust;
						
	esttab using ${stats}/output/regressions/OLShealth_`tcontrol'_`htype'_`gender'.tex,
		replace
		se
		ar2
		nomtitles
		noconst
		title("Effect on 2014 log hourly wage with health controls`thlab', `gender', `hlab'")
		nonotes
		addnotes(	"Heteroskedasticity-robust standard errors in parentheses"
					"* p $<$ 0.05, ** p $<$ 0.01, *** p $<$ 0.001")
		coeflabels(`coeffs');
		
	drop htquartile*;
	
};
};
