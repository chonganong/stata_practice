/*******************************************************************************
*	File name:		01_summary_stats.do
*  	Author(s):		Chong An Ong
*  	Written:       	06/23/2017 (of latest version)
*
*	Inputs:			clean.dta
*	Outputs:		
*	
*	Description: 
*
* 
*******************************************************************************/
 
/********************** Section 1: Preliminaries ******************************/

version 12.1
clear all
clear mata
set more off
cap log close

local input_dir  "C:\Users\Chong An\Documents\GitHub\stata_practice\analysis\input"
local temp_dir   "C:\Users\Chong An\Documents\GitHub\stata_practice\analysis\temp"
local output_dir "C:\Users\Chong An\Documents\GitHub\stata_practice\analysis\output"

log using "`temp_dir'/summary_stats", text replace

/********************** Section 2: t-test on points by hill indicator *************************/

use "`input_dir'\clean.dta", clear
ttest points, by(hill_indicator)

/********************** Section 3: Output table of number of kids from each state ******************************/

tab state_count
 
/********************** Section 4: Output table of 10 most common cities each year ******************************/

gen hill_indicator=0
replace hill_indicator=1 if strpos(home_city, "Hill")>0

/********************** Section 5: Output dataset 

********
* Save *
********

cd "`output_dir'"
save "clean.dta", replace

log close
