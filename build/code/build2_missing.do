#delimit ;

/* -----------------------------------------------------------------------------
REPLACE MEANINGFUL NEGATIVE VALUES
*/;

// no children;
replace children = 0 if children == -4;


/* -----------------------------------------------------------------------------
CODE MISSING VARIABLES
*/;

foreach var of varlist _all {;
	replace `var' = . if inlist(`var',-1,-2,-3,-4,-5);
};
	
// replace ungraded with .;
local vars 	biofather_highgrade
			biomother_highgrade
			resfather_highgrade
			resmother_highgrade
			highgrade;
			
foreach var of local vars {;
	replace `var' = . if `var' == 95;
};

// replace 'unkown' with .;
replace urban = . if urban == 2;
	
// replace 'no information';
replace sex = . if sex == 0;

// replace 'have not yet received scores';
replace sat_math = . if sat_math == 0;
replace sat_verbal = . if sat_verbal == 0;
replace act_comp = . if act_comp == 0;
