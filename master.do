#delimit ;
clear;

// choose main directory;

local OS mac; // windows, mac;

if 	"`OS'" == "windows" {;
	global maindir C:/Users/Brian/Dropbox/BrianLivingstonRA/Height/NLSY;
	};
else if "`OS'" == "mac" {;
	global maindir /Users/brianlivingston/Dropbox/BrianLivingstonRA/Height/NLSY;
	};


global maindir C:/Users/Brian/Dropbox/BrianLivingstonRA/Height/NLSY;
global build ${maindir}/build;

/* -----------------------------------------------------------------------------
BUILD DATASET
*/

do ${build}/code/build.do;
