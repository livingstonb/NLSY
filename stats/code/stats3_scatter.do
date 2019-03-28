#delimit ;
set more 1;

/* scatter plots */;

local graphopts graphregion(color(white))
				plotregion(color(white))
				bgcolor(white)
				legend(label(4 "Men") label(6 "Women"))
				legend(order(6 4));
				
local cioptsm 	est(robust)
				fcolor(blue%20)
				alwidth(none);
				
local cioptsw	est(robust)
				fcolor(red%20)
				alwidth(none);
				
if "$restriction" == "fedminwage" {;
	local restr (incomerate2014 >= 7.25);
	local restrlabel _minwage;
};
else {;
	local restr 1;
	local restrlabel;
};

if "$incvar" == "hourly" {;
	local income lincomerate2014;
};
else if "$incvar" == "annual" {;
	local income lincome2014;
};

/* -----------------------------------------------------------------------------
LOG WAGE VS HEIGHT
-----------------------------------------------------------------------------*/;

twoway (scatter `income' height2011 if (sex == 1) & `restr', msize(vtiny) mcolor(blue))
		(scatter `income' height2011 if (sex == 2) & `restr', msize(vtiny) mcolor(red))
		(lfitci `income' height2011 if (sex == 1) & `restr', lcolor(blue) `cioptsm') 
		(lfitci `income' height2011 if (sex == 2) & `restr', lcolor(red) `cioptsw') 
		if height2011 > 50,
	xtitle("2011 Height (in)")
	ytitle("2014 log ${incvar} income")
	xlabel(50(10)90)
	`graphopts';
graph export ${stats}/output/figs/log${incvar}wage_height`restrlabel'.png, replace;

/* -----------------------------------------------------------------------------
RESIDUALS OF REG OF LOG WAGE ON ABILITY VS HEIGHT
-----------------------------------------------------------------------------*/;

quietly reg `income' asvab_score_pct if `restr';
predict resid, residuals;

twoway (scatter resid height2011 if (sex == 1) & `restr', msize(vtiny) mcolor(blue))
		(scatter resid height2011 if (sex == 2) & `restr', msize(vtiny) mcolor(red))
		(lfitci resid height2011 if (sex == 1) & `restr', lcolor(blue) `cioptsm')
		(lfitci resid height2011 if (sex == 2) & `restr', lcolor(red) `cioptsw')
		if height2011 > 50,
	xtitle("2011 Height (in)")
	ytitle("Residuals")
	xlabel(50(10)90)
	`graphopts';
graph export ${stats}/output/figs/resid${incvar}_height`restrlabel'.png, replace;

drop resid;
graph close;
