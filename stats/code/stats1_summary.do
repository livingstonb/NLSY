#delimit ;

/* compute summary statistics below and above median adult height */;

/* -----------------------------------------------------------------------------
GENERATE VARIABLES
-----------------------------------------------------------------------------*/;

// median teen, adult height;
egen teenh = median(height) if year == 1997;
egen teenmedianht = max(teenh);
egen adulth = median(height) if year == 2011;
egen adultmedianht = max(adulth);
drop teenh adulth;

/* -----------------------------------------------------------------------------
COMPUTATION
-----------------------------------------------------------------------------*/;
local sumvars 	teenheight
				adultheight
				age
				lincomerate
				cumhighgrade
				evermarried
				div_sep
				resmother_highgrade
				resfather_highgrade
				teenhhsize;

mean `sumvars' if adultheight <= adultmedianht;
est store BELOWMED;
mean `sumvars' if adultheight > adultmedianht;
est store ABOVEMED;

local title1 "Adult Height <= Median";
local title2 "Adult Height > Median"; 
esttab BELOWMED ABOVEMED, 	nostar
							se
							mtitles("`title1'" "`title2'")
							coeflabels(	teenheight "Teen height (inches)"
										adultheight "Adult height (inches)"
										age "Age"
										lincomerate "ln(wage per hour)"
										cumhighgrade "Years of completed schooling"
										evermarried "Ever Married (%)"
										div_sep "Divorced or separated (%)"
										resmother_highgrade "Mother's years of schooling"
										resfather_highgrade "Father's years of schooling"
										teenhhsize "Number of HH members in youth"
										);
