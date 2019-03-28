#delimit ;
set more 1;

/* scatter plots */;

local graphopts graphregion(color(white))
				plotregion(color(white))
				bgcolor(white)
				legend(label(3 "Men") label(4 "Women"))
				legend(order(3 4));

/* -----------------------------------------------------------------------------
LOG WAGE VS HEIGHT
-----------------------------------------------------------------------------*/;

twoway (scatter lincomerate2014 height2011 if sex == 1, msize(vtiny) mcolor(blue))
		(scatter lincomerate2014 height2011 if sex == 2, msize(vtiny) mcolor(red))
		(lfit lincomerate2014 height2011 if sex == 1, lcolor(blue)) 
		(lfit lincomerate2014 height2011 if sex == 2, lcolor(red)) 
		if height2011 > 50,
	xtitle("2011 Height (in)")
	ytitle("2014 log wage ($/hr)")
	xlabel(50(10)90)
	ylabel(0(1)5)
	`graphopts';
graph export ${stats}/output/figs/logwage_height.png, replace;

/* -----------------------------------------------------------------------------
RESIDUALS OF REG OF LOG WAGE ON ABILITY VS HEIGHT
-----------------------------------------------------------------------------*/;

quietly reg lincomerate2014 asvab_score_pct if sex == 1;
predict resid1, residuals;
quietly reg lincomerate2014 asvab_score_pct if sex == 2;
predict resid2, residuals;

twoway (scatter resid1 height2011 if sex == 1, msize(vtiny) mcolor(blue))
		(scatter resid2 height2011 if sex == 2, msize(vtiny) mcolor(red))
		(lfit resid1 height2011 if sex == 1, lcolor(blue))
		(lfit resid2 height2011 if sex == 2, lcolor(red))
		if height2011 > 50,
	xtitle("2011 Height (in)")
	ytitle("Residuals")
	xlabel(50(10)90)
	`graphopts';
graph export ${stats}/output/figs/residability_height.png, replace;

drop resid*;
graph close;
