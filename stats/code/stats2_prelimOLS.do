#delimit ;
set more 1;

/* OLS estimatation of preliminary regressions */;

reg lincomerate2010 height2010, robust;
reg lincomerate2010 height2010 youngheight, robust;
reg lincomerate2010 height2010 youngheight age2010 
	resmother_highgrade resfather_highgrade
	hhsize1998, robust;
