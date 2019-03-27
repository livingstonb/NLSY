#delimit ;

/* OLS estimatation of preliminary regressions */;

keep if year == 2011;

reg adultlincomerate adultheight, robust;
reg adultlincomerate adultheight teenheight, robust;
reg adultlincomerate adultheight teenheight age 
	resmother_highgrade resfather_highgrade
	teenhhsize, robust;
