#delimit ;
set more 1;

/* compute summary statistics below and above median adult height */;

/* -----------------------------------------------------------------------------
COMPUTATION
-----------------------------------------------------------------------------*/;

local sumvars 	height1997
				height2011
				age2014
				lincomerate2014
				cumhighgrade
				evermarried2013
				div_sep2013
				resmother_highgrade
				resfather_highgrade
				siblings2011;
				
local coeffs 	height1997 "Teen height (inches)"
				height2011 "Adult height (inches)"
				age2014 "Age"
				lincomerate2014 "ln(wage per hour)"
				cumhighgrade "Years of completed schooling"
				evermarried2013 "Ever Married (\%)"
				div_sep2013 "Divorced or separated (\%)"
				resmother_highgrade "Mother's years of schooling"
				resfather_highgrade "Father's years of schooling"
				siblings2011 "Number of siblings";
					

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
	
	// median adult height;
	egen adultmedianht = median(height2011) if `cond';
	
	estimates clear;
	eststo: quietly mean `sumvars' if (height2011 <= adultmedianht) & `cond' [pweight=cumwt1997];
	eststo: quietly mean `sumvars' if (height2011 > adultmedianht) & `cond' [pweight=cumwt1997];

	local title1 "Adult Height $<=$ Median";
	local title2 "Adult Height $>$ Median"; 
	esttab using ${stats}/output/summary_`gender'.tex, 
		replace
		nonumbers
		nostar
		se
		mtitles("`title1'" "`title2'")
		coeflabels(`coeffs');
					
	drop adultmedianht;
};
