#delimit ;
set more 1;

/* OLS estimatation of preliminary regressions */;

reg lincomerate2010 height2010, robust;
reg lincomerate2010 height2010 height1997, robust;
reg lincomerate2010 height2010 height1997 age2010 
	resmother_highgrade resfather_highgrade
	siblings2011, robust;
