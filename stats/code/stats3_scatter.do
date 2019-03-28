#delimit ;
set more 1;

/* scatter plots */;

local graphopts graphregion(color(white))
				plotregion(color(white))
				bgcolor(white)
				legend(label(3 "Men") label(4 "Women"))
				legend(order(3 4));
				
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
		(lfit `income' height2011 if (sex == 1) & `restr', lcolor(blue)) 
		(lfit `income' height2011 if (sex == 2) & `restr', lcolor(red)) 
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
		(lfit resid height2011 if (sex == 1) & `restr', lcolor(blue))
		(lfit resid height2011 if (sex == 2) & `restr', lcolor(red))
		if height2011 > 50,
	xtitle("2011 Height (in)")
	ytitle("Residuals")
	xlabel(50(10)90)
	`graphopts';
graph export ${stats}/output/figs/resid${incvar}_height`restrlabel'.png, replace;

drop resid;
graph close;
