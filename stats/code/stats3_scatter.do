#delimit ;
set more 1;

/* scatter plots */;

local graphopts graphregion(color(white))
				plotregion(color(white))
				bgcolor(white)
				legend(label(4 "Men") label(6 "Women"))
				legend(order(6 4));
				
local cioptsm 	est(robust)
				fcolor(blue%20)
				alwidth(none);
				
local cioptsw	est(robust)
				fcolor(red%20)
				alwidth(none);
				
if "$restriction" == "fedminwage" {;
	local restr (incomerate2014 >= 7.25);
	local restrlabel _minwage;
};
else {;
	local restr 1;
	local restrlabel;
};

if "$incvar" == "hourly" {;
	local income lincomerate2014;
	local ymax 4;
	local ymin 2;
};
else if "$incvar" == "annual" {;
	local income lincome2014;
	local ymax 12;
	local ymin 9;
};

if "$fit" == "linear" {;
	local fittype lfitci;
};
else if "$fit" == "quadr" {;
	local fittype qfitci;
};
else if "$fit" == "fpoly" {;
	local fittype fpfitci;
};

/* -----------------------------------------------------------------------------
LOG WAGE VS HEIGHT
-----------------------------------------------------------------------------*/;

if ("$scale" == "narrow") & inlist("$fit","linear","quadr") {;
	if "$fit" == "linear" {;
		quietly reg `income' height2011 if (sex == 1) & `restr', robust;
		predict lfit1 if (sex == 1) & `restr', xb;
		quietly reg `income' height2011 if (sex == 2) & `restr', robust;
		predict lfit2 if (sex == 2) & `restr', xb;
	};
	else if "$fit" == "quadr" {;
		gen height2011sq = height2011^2;
		quietly reg `income' height2011 height2011sq if (sex == 1) & `restr', robust;
		predict lfit1 if (sex == 1) & `restr', xb;
		quietly reg `income' height2011 height2011sq if (sex == 1) & `restr', robust;
		predict lfit2 if (sex == 1) & `restr', xb;
		drop height2011sq;
	};
	
	twoway 	(scatter `income' height2011 if (sex == 1) & `restr' & inrange(`income',`ymin',`ymax'), msize(vtiny) mcolor(blue))
			(scatter `income' height2011 if (sex == 2) & `restr' & inrange(`income',`ymin',`ymax'), msize(vtiny) mcolor(red))
			(line lfit1 height2011 if (sex == 1) & `restr' & inrange(lfit1,`ymin',`ymax'), lcolor(blue))
			(line lfit2 height2011 if (sex == 2) & `restr' & inrange(lfit2,`ymin',`ymax'), lcolor(red)),
			xtitle("2011 Height (in)")
			ytitle("2014 log ${incvar} income")
			xlabel(50(10)90)
			plotregion(color(white))
			bgcolor(white)
			graphregion(color(white))
			legend(label(3 "Men") label(4 "Women"))
			legend(order(4 3));
	graph export ${stats}/output/figs/log${incvar}wage_height`restrlabel'_narrow_${fit}.png, replace;
	drop lfit*;
	graph close;

};
else if "$scale" == "normal" {;
	twoway 	(scatter `income' height2011 if (sex == 1) & `restr', msize(vtiny) mcolor(blue))
			(scatter `income' height2011 if (sex == 2) & `restr', msize(vtiny) mcolor(red))
			(`fittype' `income' height2011 if (sex == 1) & `restr', lcolor(blue) `cioptsm') 
			(`fittype' `income' height2011 if (sex == 2) & `restr', lcolor(red) `cioptsw'),
			xtitle("2011 Height (in)")
			ytitle("2014 log ${incvar} income")
			xlabel(50(10)90)
			`graphopts';
	graph export ${stats}/output/figs/log${incvar}wage_height`restrlabel'_${fit}.png, replace;
	graph close;
};

/* -----------------------------------------------------------------------------
RESIDUALS OF REG OF LOG WAGE ON ABILITY VS HEIGHT
-----------------------------------------------------------------------------*/;

if ("$scale" == "normal") & ("$fit" == "linear") {;

	quietly reg `income' asvab_score_pct if `restr';
	predict resid, residuals;

	twoway (scatter resid height2011 if (sex == 1) & `restr', msize(vtiny) mcolor(blue))
			(scatter resid height2011 if (sex == 2) & `restr', msize(vtiny) mcolor(red))
			(lfitci resid height2011 if (sex == 1) & `restr', lcolor(blue) `cioptsm')
			(lfitci resid height2011 if (sex == 2) & `restr', lcolor(red) `cioptsw'),
		xtitle("2011 Height (in)")
		ytitle("Residuals")
		xlabel(50(10)90)
		`graphopts';
	graph export ${stats}/output/figs/resid${incvar}_height`restrlabel'.png, replace;

	drop resid;
	graph close;
};
