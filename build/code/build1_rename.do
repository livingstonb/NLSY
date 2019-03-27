#delimit ;
set more 1;

/* -----------------------------------------------------------------------------
RENAME VARIABLES
-----------------------------------------------------------------------------*/;
quietly {;
	rename R0000100 id;
	rename R0536300 sex;
	rename R1482600 race;
	rename R0536401 birthmonth;
	rename R0536402 birthyear;
	rename R1235800 sampletype;
	rename R1194100 age1997;
	rename R2553500 age1998;
	rename R3876300 age1999;
	rename R5453700 age2000;
	rename R7216000 age2001;
	rename S1531400 age2002;
	rename S2001000 age2003;
	rename S3801100 age2004;
	rename S5401000 age2005;
	rename S7501200 age2006;
	rename T0008500 age2007;
	rename T2011100 age2008;
	rename T3601500 age2009;
	rename T5201400 age2010;
	rename T6651300 age2011;
	rename T8123600 age2013;
	rename U0001800 age2015;
	rename R1302400 biofather_highgrade;
	rename R1302500 biomother_highgrade;
	rename R1302600 resfather_highgrade;
	rename R1302700 resmother_highgrade;
	rename R2563700 hhsize1998;
	rename R3885300 hhsize1999;
	rename R5464500 hhsize2000;
	rename R7228200 hhsize2001;
	rename S1542100 hhsize2002;
	rename S2011900 hhsize2003;
	rename S3813400 hhsize2004;
	rename S5413000 hhsize2005;
	rename S7513900 hhsize2006;
	rename T0014300 hhsize2007;
	rename T2016400 hhsize2008;
	rename T3606700 hhsize2009;
	rename T5207100 hhsize2010;
	rename T6656900 hhsize2011;
	rename T8129300 hhsize2013;
	rename U0009100 hhsize2015;
	rename R2563201 highgrade1998;
	rename R3884801 highgrade1999;
	rename R5464001 highgrade2000;
	rename R7227701 highgrade2001;
	rename S1541601 highgrade2002;
	rename S2011401 highgrade2003;
	rename S3812301 highgrade2004;
	rename S5412700 highgrade2005;
	rename S7513600 highgrade2006;
	rename T0014000 highgrade2007;
	rename T2016100 highgrade2008;
	rename T3606400 highgrade2009;
	rename T5206800 highgrade2010;
	rename T6656600 highgrade2011;
	rename T8129000 highgrade2013;
	rename Z9083800 cumhighgrade;
	rename R2564101 highdegr1998;
	rename R3885701 highdegr1999;
	rename R5464901 highdegr2000;
	rename R7228601 highdegr2001;
	rename S1542501 highdegr2002;
	rename S2012301 highdegr2003;
	rename S3813801 highdegr2004;
	rename S5413400 highdegr2005;
	rename S7514300 highdegr2006;
	rename T0014700 highdegr2007;
	rename T2016800 highdegr2008;
	rename T3607100 highdegr2009;
	rename T5207500 highdegr2010;
	rename T6657300 highdegr2011;
	rename T8129700 highdegr2013;
	rename U0009400 highdegr2015;
	rename R9829600 asvab_score_pct;
	rename Z9033700 sat_math;
	rename Z9033900 sat_verbal;
	rename Z9034100 act_comp;
	rename R5473600 piat2000;
	rename R7237300 piat2001;
	rename S1552600 piat2002;
	rename R9792900 hsgpa_lastyr;
	rename R9871900 hsgpa_cum;
	rename R9793200 psat_math;
	rename R9793300 psat_verbal;
	rename R9793000 hsrank;
	rename R9793100 hsclasssize;
	rename B0004600 cgpa;
	rename R2341200 income1997; // reported in 1998;
	rename R3650200 income1998;
	rename R5098900 income1999;
	rename R6827500 income2000;
	rename S1055800 income2001;
	rename S3134600 income2002;
	rename S4799600 income2003;
	rename S6501000 income2004;
	rename S8496500 income2005;
	rename T0889800 income2006;
	rename T3003000 income2007;
	rename T4406000 income2008;
	rename T6055500 income2009;
	rename T7545600 income2010;
	rename T8976700 income2012;
	rename U0956900 income2014;
	rename R1211100 children1997;
	rename R2570100 children1998;
	rename R3892100 children1999;
	rename R5474100 children2000;
	rename R7237800 children2001;
	rename S1553100 children2002;
	rename S2022700 children2003;
	rename S3823600 children2004;
	rename S5423600 children2005;
	rename S7525700 children2006;
	rename T0026000 children2007;
	rename T2020900 children2008;
	rename T3611600 children2009;
	rename T5211700 children2010;
	rename T6663100 children2011;
	rename T8134300 children2013;
	rename U0014800 children2015;
	rename R0320600 health1997;
	rename R2164000 health1998;
	rename R3481900 health1999;
	rename R4880100 health2000;
	rename R6497500 health2001;
	rename S1225000 health2002;
	rename S3302500 health2003;
	rename S4919500 health2004;
	rename S6661100 health2005;
	rename S8644200 health2006;
	rename T1049500 health2007;
	rename T3144600 health2008;
	rename T4562200 health2009;
	rename T6206400 health2010;
	rename T7703800 health2011;
	rename T9093100 health2013;
	rename U1096500 health2015;
	rename R0681200 health_parentans;
	rename T4581900 energy2009;
	rename T6214200 energy2010;
	rename T7711600 energy2011;
	rename T9113600 energy2013;
	rename U1104000 energy2015;
	rename R0322500 feet1997;
	rename R2164100 feet1998;
	rename R3482000 feet1999;
	rename R4880200 feet2000;
	rename R6497600 feet2001;
	rename S0905500 feet2002;
	rename S2978200 feet2003;
	rename S4677000 feet2004;
	rename S6309200 feet2005;
	rename S8330100 feet2006;
	rename T0737900 feet2007;
	rename T2780200 feet2008;
	rename T4494600 feet2009;
	rename T6141700 feet2010;
	rename T7635600 feet2011;
	rename R0322600 inches1997;
	rename R2164200 inches1998;
	rename R3482100 inches1999;
	rename R4880300 inches2000;
	rename R6497700 inches2001;
	rename S0905600 inches2002;
	rename S2978300 inches2003;
	rename S4677100 inches2004;
	rename S6309300 inches2005;
	rename S8330200 inches2006;
	rename T0738000 inches2007;
	rename T2780300 inches2008;
	rename T4494700 inches2009;
	rename T6141800 inches2010;
	rename T7635700 inches2011;
	rename R0322700 weight1997;
	rename R2164300 weight1998;
	rename R3482200 weight1999;
	rename R4880400 weight2000;
	rename S0905700 weight2002;
	rename S2978400 weight2003;
	rename S4677200 weight2004;
	rename S6309400 weight2005;
	rename S8330300 weight2006;
	rename T0738100 weight2007;
	rename T2780400 weight2008;
	rename T4494800 weight2009;
	rename T6141900 weight2010;
	rename T7635800 weight2011;
	rename T9039300 weight2013;
	rename U1028700 weight2015;
	rename T4581400 healthlim2009;
	rename T6213700 healthlim2010;
	rename T7711100 healthlim2011;
	rename T9113100 healthlim2013;
	rename U1103500 healthlim2015;
	rename T4581600 emotlim2009;
	rename T6213900 emotlim2010;
	rename T7711300 emotlim2011;
	rename T9113300 emotlim2013;
	rename U1103700 emotlim2015;
	rename T4581800 painlim2009;
	rename T6214100 painlim2010;
	rename T7711500 painlim2011;
	rename T9113500 painlim2013;
	rename U1103900 painlim2015;
	rename E8033100 arrests;
	rename E8043100 incarcerations;
	rename R0444000 bullied_12u;
	rename R3548100 bullied_12to18_y1999;
	rename R4963900 bullied_12to18_y2000;
	rename R6596800 bullied_12to18_y2001;
	rename S0980400 bullied_12to18_y2002;
	rename S3019500 bullied_12to18_y2003;
	rename R1236101 cumwt1997;
	rename R2600301 cumwt1998;
	rename R3923701 cumwt1999;
	rename R5510600 cumwt2000;
	rename R7274200 cumwt2001;
	rename S1598100 cumwt2002;
	rename S2067000 cumwt2003;
	rename S3861600 cumwt2004;
	rename S5444200 cumwt2005;
	rename S7545500 cumwt2006;
	rename T0042100 cumwt2007;
	rename T2022500 cumwt2008;
	rename T3613300 cumwt2009;
	rename T5213200 cumwt2010;
	rename T6665000 cumwt2011;
	rename T8135900 cumwt2013;
	rename U0017100 cumwt2015;
	rename R1236201 panwt1997;
	rename R2600401 panwt1998;
	rename R3958501 panwt1999;
	rename R5510700 panwt2000;
	rename R7274300 panwt2001;
	rename S1598200 panwt2002;
	rename S2067100 panwt2003;
	rename S3861700 panwt2004;
	rename S5444300 panwt2005;
	rename S7545600 panwt2006;
	rename T0042200 panwt2007;
	rename T2022600 panwt2008;
	rename T3613400 panwt2009;
	rename T5213300 panwt2010;
	rename T6665100 panwt2011;
	rename T8136000 panwt2013;
	rename U0017200 panwt2015;
	rename Z9048900 networth20;
	rename Z9049000 networth25;
	rename Z9121900 networth30;
	rename Z9141400 networth35;
	rename R1204500 hhincome1997;
	rename R2563300 hhincome1998;
	rename R3884900 hhincome1999;
	rename R5464100 hhincome2000;
	rename R7227800 hhincome2001;
	rename S1541700 hhincome2002;
	rename S2011500 hhincome2003;
	rename R1204600 hhincsource1997;
	rename R1204700 networthP1997;
	rename Z9069800 hours1980;
	rename Z9069900 hours1981;
	rename Z9070000 hours1982;
	rename Z9070100 hours1983;
	rename Z9070200 hours1984;
	rename Z9070300 hours1985;
	rename Z9070400 hours1986;
	rename Z9070500 hours1987;
	rename Z9070600 hours1988;
	rename Z9070700 hours1989;
	rename Z9070800 hours1990;
	rename Z9070900 hours1991;
	rename Z9071000 hours1992;
	rename Z9071100 hours1993;
	rename Z9071200 hours1994;
	rename Z9071300 hours1995;
	rename Z9071400 hours1996;
	rename Z9071500 hours1997;
	rename Z9071600 hours1998;
	rename Z9071700 hours1999;
	rename Z9068800 hours2000;
	rename Z9068900 hours2001;
	rename Z9069000 hours2002;
	rename Z9069100 hours2003;
	rename Z9069200 hours2004;
	rename Z9069300 hours2005;
	rename Z9069400 hours2006;
	rename Z9069500 hours2007;
	rename Z9069600 hours2008;
	rename Z9069700 hours2009;
	rename Z9069701 hours2010;
	rename Z9069702 hours2011;
	rename Z9069703 hours2012;
	rename Z9069704 hours2013;
	rename Z9069705 hours2014;
	rename Z9069706 hours2015;
	rename Z9069707 hours2016;
	rename T1050400 lim_kindwork2007;
	rename T3145600 lim_kindwork2008;
	rename T4565900 lim_kindwork2009;
	rename T6210100 lim_kindwork2010;
	rename T7707500 lim_kindwork2011;
	rename T9093200 lim_kindwork2012;
	rename U1100200 lim_kindwork2013;
	rename T1050500 lim_amountwork2007;
	rename T3145700 lim_amountwork2008;
	rename T4566000 lim_amountwork2009;
	rename T6210200 lim_amountwork2010;
	rename T7707600 lim_amountwork2011;
	rename T9093300 lim_amountwork2013;
	rename U1100300 lim_amountwork2015;
	rename S3659000 occupation1997;
	rename S3681000 occupation1998;
	rename S3697000 occupation1999;
	rename S3713000 occupation2000;
	rename S3729000 occupation2001;
	rename S1603000 occupation2002;
	rename S3757000 occupation2003;
	rename S5041700 occupation2004;
	rename S6783100 occupation2005;
	rename S8689700 occupation2006;
	rename T1109400 occupation2007;
	rename T3186900 occupation2008;
	rename T4597800 occupation2009;
	rename T6231000 occupation2010;
	rename T7732100 occupation2011;
	rename T9133500 occupation2013;
	rename U1127100 occupation2015;
	rename R1217500 urban1997;
	rename R2576800 urban1998;
	rename R3899100 urban1999;
	rename R5484100 urban2000;
	rename R7248400 urban2001;
	rename S1564300 urban2002;
	rename S2034400 urban2003;
	rename S3835800 urban2004;
	rename S5436300 urban2005;
	rename S7537100 urban2006;
	rename T0033700 urban2007;
	rename T2021300 urban2008;
	rename T3612000 urban2009;
	rename T5211900 urban2010;
	rename T6663300 urban2011;
	rename T8134500 urban2013;
	rename U0015000 urban2015;
	rename R2558800 cregion1998;
	rename R3880300 cregion1999;
	rename R5459400 cregion2000;
	rename R7222400 cregion2001;
	rename S1535500 cregion2002;
	rename S2005400 cregion2003;
	rename S3805700 cregion2004;
	rename S5405600 cregion2005;
	rename S7506100 cregion2006;
	rename T0009400 cregion2007;
	rename T2012100 cregion2008;
	rename T3602100 cregion2009;
	rename T5202300 cregion2010;
	rename T6652100 cregion2011;
	rename T8123700 cregion2013;
	rename U0001900 cregion2015;
	rename Z9062000 workwks1980;
	rename Z9062100 workwks1981;
	rename Z9062200 workwks1982;
	rename Z9062300 workwks1983;
	rename Z9062400 workwks1984;
	rename Z9062500 workwks1985;
	rename Z9062600 workwks1986;
	rename Z9062700 workwks1987;
	rename Z9062800 workwks1988;
	rename Z9062900 workwks1989;
	rename Z9063000 workwks1990;
	rename Z9063100 workwks1991;
	rename Z9063200 workwks1992;
	rename Z9063300 workwks1993;
	rename Z9063400 workwks1994;
	rename Z9063500 workwks1995;
	rename Z9063600 workwks1996;
	rename Z9063700 workwks1997;
	rename Z9063800 workwks1998;
	rename Z9063900 workwks1999;
	rename Z9061000 workwks2000;
	rename Z9061100 workwks2001;
	rename Z9061200 workwks2002;
	rename Z9061300 workwks2003;
	rename Z9061400 workwks2004;
	rename Z9061500 workwks2005;
	rename Z9061600 workwks2006;
	rename Z9061700 workwks2007;
	rename Z9061800 workwks2008;
	rename Z9061900 workwks2009;
	rename Z9061901 workwks2010;
	rename Z9061902 workwks2011;
	rename Z9061903 workwks2012;
	rename Z9061904 workwks2013;
	rename Z9061905 workwks2014;
	rename Z9061906 workwks2015;
	rename Z9061907 workwks2016;
	rename R1210300 married1997;
	rename R2569400 married1998;
	rename R3891400 married1999;
	rename R5473400 married2000;
	rename R7237100 married2001;
	rename S1552400 married2002;
	rename S2022200 married2003;
	rename S3823100 married2004;
	rename S5423100 married2005;
	rename S7525200 married2006;
	rename T0025500 married2007;
	rename T2020400 married2008;
	rename T3611100 married2009;
	rename T5211500 married2010;
	rename T6662900 married2011;
	rename T8134100 married2013;
	rename U0014600 married2015;
	rename T6745900 siblings2011;
	rename T8219500	siblings2013;
	rename U0114100 siblings2015;
};

