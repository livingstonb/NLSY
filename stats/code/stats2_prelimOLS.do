#delimit ;
set more 1;

/* OLS estimatation of preliminary regressions */;
estimates clear;
eststo: quietly reg lincomerate2010 height2010, robust;
eststo: quietly reg lincomerate2010 height2010 height1997, robust;
eststo: quietly reg lincomerate2010 height2010 height1997 asvab_score_pct, robust;
eststo: quietly reg lincomerate2010 height2010 height1997 age2010, robust;
eststo: quietly reg lincomerate2010 height2010 height1997 
	resmother_highgrade resfather_highgrade
	siblings2011 parentnetworth1997, robust;
eststo: quietly reg lincomerate2010 height2010 height1997 
	resmother_highgrade resfather_highgrade
	siblings2011 parentnetworth1997 age2010 asvab_score_pct, robust;

esttab using ${stats}/output/prelimOLS.tex,
	replace
	se
	ar2
	nomtitles
	noconst
	coeflabels(	height1997 "Teen height (in)"
				height2010 "Adult height (in)"
				age2010 "Age in 2010"
				lincomerate2010 "ln(wage per hour), 2010"
				cumhighgrade "Years of completed schooling"
				evermarried2010 "Ever Married (%)"
				div_sep2010 "Divorced or separated (%)"
				resmother_highgrade "Mother's years of schooling"
				resfather_highgrade "Father's years of schooling"
				siblings2011 "Number of siblings"
				asvab_score_pct "ASVAB pctile score"
				parentnetworth1997 "1997 HH net worth, ($100,000s)"
				);
