#delimit ;

/* build.do constructs a cleaned dataset from the NLSY97 dictionary in 'input' */

cd ${build};

// read data;
quietly infile using input/NLSY97.dct;
quietly do input/NLSY97-value-labels.do;

// rename variables;
do code/build1_rename.do;

// reshape long;
local longvars 	age 
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
				occupation;

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

// code missing variables;
do code/build2_missing.do;

// generate variables;
do code/build3_genvars.do;

// save cleaned dataset;
save output/NLSY_cleaned.dta, replace;
