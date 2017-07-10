clear all
clear mata
set more off

**********************IMPORTANT**************************
*Change the paths to match path on your computer locally*
*********************************************************
//Path of repository
global repository "C:\Users\Chong An\Documents\GitHub\stata_practice"

***********************************************
//Run all code in all folders in correct order*
***********************************************
foreach folder in build_dataset analysis {
	cd "$repository/`folder'"
	do "run_directory".do
}

di "KLAAR"
