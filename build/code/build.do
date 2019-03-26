#delimit ;

/* build.do constructs a cleaned dataset from the NLSY97 dictionary in 'input' */

cd ${build};

// read data;
clear;
quietly infile using input/NLSY97.dct;
quietly do input/NLSY97-value-labels.do;

// rename variables;
do code/build1_rename.do;

// reshape long;
local longvars	age 
				hhsize 
				highgrade 
				highdegr 
				piat
				wage
				children
				health
				energy
				feet
				inches
				weight
				healthlim
				emotlim
				painlim
				bullied_12to18_y
				cumwt
				panwt
				networth
				hhincome
				hhincsource
				hours
				lim_kindwork
				lim_amountwork
				occupation
				urban
				cregion;

quietly reshape long `longvars', i(id) j(year);
label variable year "INTERVIEW YEAR";
label variable age "AGE AT INTERVIEW";
label variable hhsize "HH SIZE";
label variable highgrade "HIGHEST GRADE COMPLETED";
label variable highdegr "HIGHEST DEG COMPLETED";
label variable piat "PIAT MATH SCORE (PCT)";
label variable wage "TOT INC FROM WAGES, SALARY IN PAST YEAR";
label variable children "NUMBER OF CHILDREN";
label variable health "HOW IS GENERAL HEALTH?";
label variable energy "ENERGY LEVEL, PAST 4 WKS";
label variable feet "HEIGHT, FT";
label variable inches "HEATH, IN";
label variable weight "WEIGHT, LBS";
label variable healthlim "HEALTH LIMITATIONS ON PROD";
label variable emotlim "EMOTIONAL LIMITATIONS ON PROD";
label variable painlim "PAIN LIMITATIONS ON PROD";
label variable cumwt "SAMPLE WTS, CUMULATIVE METHOD";
label variable panwt "SAMPLE WTS, PANEL METHOD";
label variable networth "HH NET WORTH";
label variable hhincome "HH INCOME";
label variable hhincsource "HH INCOME SOURCE";
label variable hours "ANNUAL HOURS WORKED";
label variable lim_kindwork "LIMITED IN KIND OF WORK BC OF HEALTH";
label variable lim_amountwork "LIMITED IN AMOUNT OF WORK BC OF HEALTH";
label variable occupation "OCC OF MOST RECENT JOB, 2002 CENSUS CODE";
label variable urban "CURRENT RESIDENCE IN URBAN/RURAL AREA";
label variable cregion "CENSUS REGION OF RESIDENCE";

label define deglab 0 "NONE" 1 "GED" 2 "HS" 3 "ASSOCIATES" 4 "BS" 5 "MS" 6 "PHD" 7 "PRO";
label values highdegr deglab;
label define healthlab 1 "EXCELLENT" 2 "VERY GOOD" 3 "GOOD" 4 "FAIR" 5 "POOR";
label values health healthlab;
label define limwork 1 "YES" 0 "NO";
label values lim_kindwork limwork;
label values lim_amountwork limwork;
label define urbanlab 0 "RURAL" 1 "URBAN";
label values urban urbanlab;
label define regionlab 1 "NORTHEAST" 2 "NORTH CENTRAL" 3 "SOUTH" 4 "WEST";
label values cregion regionlab;

// code missing variables;
do code/build2_missing.do;

// generate variables;
do code/build3_genvars.do;

// save cleaned dataset;
save output/NLSY_cleaned.dta, replace;
