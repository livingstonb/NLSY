#delimit ;
set more 1;

/* scatter plots */;

local graphopts note("")
				legend(off)
				graphregion(color(white))
				plotregion(color(white))
				bgcolor(white);

/* -----------------------------------------------------------------------------
LOG WAGE VS HEIGHT
-----------------------------------------------------------------------------*/;

twoway (scatter lincomerate2014 height2011, msize(vsmall))
		(lfit lincomerate2014 height2011) 
		if height2011 > 50 & lincomerate2014 > 0,
	by(sex, `graphopts')
	xtitle("2011 Height (in)")
	ytitle("2014 log wage ($/hr)")
	xlabel(50(10)90)
	ylabel(0(1)5);
graph export ${stats}/output/figs/logwage_height.png, replace;

/* -----------------------------------------------------------------------------
RESIDUALS OF REG OF LOG WAGE ON ABILITY VS HEIGHT
-----------------------------------------------------------------------------*/;

quietly reg lincomerate2014 asvab_score_pct;
predict resid, residuals;

twoway scatter resid height2011 
	if lincomerate2014 > 0 & height2011 > 50,
	by(sex, `graphopts')
	msize(vsmall)
	xtitle("2011 Height (in)")
	ytitle("Residuals")
	xlabel(50(10)90);
graph export ${stats}/output/figs/residability_height.png, replace;

drop resid;
graph close;
