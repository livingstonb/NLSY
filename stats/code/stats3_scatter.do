#delimit ;

twoway (scatter lincomerate2014 height2011)
		(lfit lincomerate2014 height2011) 
		if height2011 > 50 & lincomerate2014 > 0,
	by(sex)
	title("Log wage vs. adult height")
	xtitle("2011 Height (in)")
	ytitle("2014 log wage ($/hr)")
	xlabel(50(10)90)
	ylabel(0(1)5)
	legend(off);

quietly reg lincomerate2014 asvab_score_pct;
predict resid, residuals;

twoway scatter resid height2011 
	if lincomerate2014 > 0 & height2011 > 50,
	by(sex, title("Residuals of regression of log wage on ability") note(""))
	xtitle("2011 Height (in)")
	ytitle("Residuals")
	xlabel(50(10)90)
	legend(off);
drop resid;
