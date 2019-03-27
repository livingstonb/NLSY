#delimit ;
set more 1;

/* -----------------------------------------------------------------------------
VARIABLE CREATION
-----------------------------------------------------------------------------*/;

label define toplabel 1 "YES" 0 "NO";

// topcode indicator for income;
gen inctopcode = 0 if !missing(income);
replace inctopcode = 1 if (income == 14048) & (year == 1998);
replace inctopcode = 1 if (income == 25249) & (year == 1999);
replace inctopcode = 1 if (income == 30623) & (year == 2000);
replace inctopcode = 1 if (income == 35558) & (year == 2001);
replace inctopcode = 1 if (income == 42458) & (year == 2002);
replace inctopcode = 1 if (income == 44091) & (year == 2003);
replace inctopcode = 1 if (income == 70712) & (year == 2004);
replace inctopcode = 1 if (income == 69342) & (year == 2005);
replace inctopcode = 1 if (income == 80471) & (year == 2006);
replace inctopcode = 1 if (income == 112215) & (year == 2007);
replace inctopcode = 1 if (income == 104353) & (year == 2008);
replace inctopcode = 1 if (income == 121993) & (year == 2009);
replace inctopcode = 1 if (income == 130254) & (year == 2010);
replace inctopcode = 1 if (income == 146002) & (year == 2011);
replace inctopcode = 1 if (income == 180331) & (year == 2013);
replace inctopcode = 1 if (income == 212641) & (year == 2015);
label variable inctopcode "ANNUAL INCOME, TOPCODED?";
label values inctopcode toplabel;

// topcode indicator for net worth;
gen nwtopcode20 = 0 if !missing(networth20);
replace nwtopcode20 = 1 if networth20 == 600000;
label variable nwtopcode20 "NET WORTH AT AGE 20, TOPCODED?";

gen nwtopcode25 = 0 if !missing(networth25);
replace nwtopcode25 = 1 if networth25 == 600000;
label variable nwtopcode25 "NET WORTH AT AGE 25, TOPCODED?";

gen nwtopcode30 = 0 if !missing(networth30);
replace nwtopcode30 = 1 if networth30 == 600000;
label variable nwtopcode30 "NET WORTH AT AGE 30, TOPCODED?";

gen nwtopcode35 = 0 if !missing(networth35);
replace nwtopcode35 = 1 if networth35 == 600000;
label variable nwtopcode35 "NET WORTH AT AGE 35, TOPCODED?";

label values nwtopcode20 toplabel;
label values nwtopcode25 toplabel;
label values nwtopcode30 toplabel;
label values nwtopcode35 toplabel;

// topcode indicator for 1997 hh net worth according to parent;
gen parentnetworth1997topcode = 0 if !missing(parentnetworth1997);
replace parentnetworth1997topcode = 1 if parentnetworth1997 == 600000;
label variable parentnetworth1997topcode "1997 NET WORTH ACCD TO PARENT, TOPCODED?";
label values parentnetworth1997topcode toplabel;

// topcode indicator for gross hh income;
gen hhinctopcode = 0 if !missing(hhincome);
replace hhinctopcode = 1 if (hhincome == 246474) & (year == 1997);
replace hhinctopcode = 1 if (hhincome == 425586) & (year == 1998);
replace hhinctopcode = 1 if (hhincome == 291681) & (year == 1999);
replace hhinctopcode = 1 if (hhincome == 270543) & (year == 2000);
replace hhinctopcode = 1 if (hhincome == 285805) & (year == 2001);
replace hhinctopcode = 1 if (hhincome == 267940) & (year == 2002);
replace hhinctopcode = 1 if (hhincome == 257697) & (year == 2003);
label variable hhinctopcode "GROSS HH INC, TOPCODED?";
label values hhinctopcode toplabel;

// replace energy variable with a time-invariant summary;
bysort id: egen energy29 = max(energy);
replace energy29 = . if energy29 == 0;
label variable energy29 "ENERGY AT 29, LAST 4 WKS";
label define energylab 	1 "ALL OF THE TIME"
						2 "MOST OF THE TIME"
						3 "A GOOD BIT OF THE TIME"
						4 "SOME OF THE TIME"
						5 "A LITTLE OF THE TIME"
						6 "NONE OF THE TIME";
label values energy29 energylab;
drop energy;

// replace health, pain, and emot limitations with time-invariant summary;
bysort id: egen healthlim29 = max(healthlim);
bysort id: egen emotlim29 = max(emotlim);
bysort id: egen painlim29 = max(painlim);
egen prodlimitation29 = rowmax(healthlim29 emotlim29 painlim29);
label variable healthlim29 "HEALTH LIMITATIONS ON PROD AT 29";
label variable emotlim29 "EMOTIONAL LIMTITATIONS ON PROD AT 29";
label variable painlim29 "PAIN LIMITATIONS ON PROD AT 29";
label variable prodlimitation29 "SUMMARY OF LIMITATIONS ON PROD AT 29";
label define limitlab 1 "YES A LOT" 2 "YES A LITTLE" 3 "NO NOT AT ALL";
label values healthlim29 limitlab;
label values emotlim29 limitlab;
label values painlim29 limitlab;
label values prodlimitation29 limitlab;
drop healthlim emotlim painlim;

// bullied between ages 12 and 18;
bysort id: egen bullied_12to18 = max(bullied_12to18_y);
drop bullied_12to18_y;
label define bullied_12to18lab 1 "YES" 0 "NO";
label values bullied_12to18 bullied_12to18lab;
label variable bullied_12to18 "BULLIED BETWEEN AGES 12 AND 18";

// height variables;
gen height = feet * 12 + inches;
label variable height "TOTAL HEIGHT IN INCHES";

xtile quartile_height1997 = height1997, nq(4);
quietly tab quartile_height1997, gen(h1997quartile);
label variable quartile_height1997 "QUARTILE OF 1997 HEIGHT";

xtile quartile_height2011 = height2011, nq(4);
quietly tab quartile_height2011, gen(h2011quartile);
label variable quartile_height2001 "QUARTILE OF 2001 HEIGHT";

// income variables;
gen incomerate = income / hours;
gen lincomerate = log(incomerate);
gen lincome = log(income);
label variable incomerate "INCOME/HR WORKED, CONVERTED FROM ANN INC";
label variable lincomerate "LOG INCOME/HR WORKED, CONVERTED FROM ANN INC";
label variable lincome "LOG ANNUAL INCOME";

gen lparentincome1996 = log(parent1inc1996 + parent2inc1996);
label variable lparentincome1996 "TOTAL PARENT INCOME 1996, ANNUAL";

// marital status;
gen evermarried = 1 if inlist(married,1,2,3,4);
replace evermarried = 0 if married == 0;
replace evermarried = . if missing(married);
gen div_sep = inlist(married,2,3);
replace div_sep = 0 if inlist(married,0,1,4);
replace div_sep = . if missing(married);

label define yesno 0 "NO" 1 "YES";
label variable evermarried "EVER MARRIED?";
label values evermarried yesno;
label variable div_sep "DIVORCED OR SEPARATED?";
label values div_sep yesno;

/* -----------------------------------------------------------------------------
VARIABLE ADJUSTMENTS
-----------------------------------------------------------------------------*/;

// data is provided with 2 implied decimal places (e.g. 300 instead of 3.00);
replace cgpa = cgpa / 100;
replace cumwt = cumwt / 100;
replace panwt = panwt / 100;

// adjust parent reported net worth to be reported in millions;
replace parentnetworth1997 = parentnetworth1997 / 1000000;
label variable parentnetworth1997 "HH NET WORTH RPTD BY PARENT, IN MILLIONS";

// ASVAB provided with 3 implied decimal places;
replace asvab_score_pct = asvab_score_pct / 1000;

