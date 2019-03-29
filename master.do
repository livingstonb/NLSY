#delimit ;
set more 1;

clear;

// choose main directory;

local OS mac; // windows, mac;

if 	"`OS'" == "windows" {;
	global maindir C:/Users/Brian/Dropbox/BrianLivingstonRA/Height/NLSY;
};
else if "`OS'" == "windows2" {;
	global maindir C:/Users/Brian-laptop/Dropbox/BrianLivingstonRA/Height/NLSY;
};
else if "`OS'" == "mac" {;
	global maindir /Users/brianlivingston/Dropbox/BrianLivingstonRA/Height/NLSY;
};

global build ${maindir}/build;
global stats ${maindir}/stats;

/* -----------------------------------------------------------------------------
BUILD DATASET
------------------------------------------------------------------------------*/

do ${build}/code/build.do;

/* -----------------------------------------------------------------------------
COMPUTE STATISTICS
------------------------------------------------------------------------------*/

do ${stats}/code/stats.do;
