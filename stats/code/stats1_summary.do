#delimit ;
set more 1;

/* compute summary statistics below and above median adult height */;

/* -----------------------------------------------------------------------------
HOUSEKEEPING
-----------------------------------------------------------------------------*/;

// median teen, adult height;
egen teenmedianht = median(height1997);
egen adultmedianht = median(height2010);

/* -----------------------------------------------------------------------------
COMPUTATION
-----------------------------------------------------------------------------*/;
local sumvars 	height1997
				height2010
				age2010
				lincomerate2010
				cumhighgrade
				evermarried2010
				div_sep2010
				resmother_highgrade
				resfather_highgrade
				siblings2011;

estimates clear;
eststo: quietly mean `sumvars' if height2010 <= adultmedianht [pweight=cumwt1997];
eststo: quietly mean `sumvars' if height2010 > adultmedianht [pweight=cumwt1997];

local title1 "Adult Height <= Median";
local title2 "Adult Height > Median"; 
esttab using ${stats}/output/summary.tex, 
	replace
	nonumbers
	nostar
	se
	mtitles("`title1'" "`title2'")
	coeflabels(	height1997 "Teen height (inches)"
				height2010 "Adult height (inches)"
				age2010 "Age"
				lincomerate2010 "ln(wage per hour)"
				cumhighgrade "Years of completed schooling"
				evermarried2010 "Ever Married (%)"
				div_sep2010 "Divorced or separated (%)"
				resmother_highgrade "Mother's years of schooling"
				resfather_highgrade "Father's years of schooling"
				siblings2011 "Number of siblings"
				);
