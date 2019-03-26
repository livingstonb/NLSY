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
mean teenheight adultheight age lincomerate teenhhsize if adultheight <= adultmedianht;
est store BELOWMED;
mean teenheight adultheight age lincomerate teenhhsize if adultheight > adultmedianht;
est store ABOVEMED;
esttab BELOWMED ABOVEMED;
