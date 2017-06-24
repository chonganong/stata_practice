/*******************************************************************************
*	File name:		02_regressions.do
*  	Author(s):		Chong An Ong
*  	Written:       	06/23/2017 (of latest version)
*
*	Inputs:			clean.dta
*	Outputs:		
*	
*	Description:	i.	Regression of rank on points
*					ii.	Regression of rank on points with state fixed effect
*					iii.	Regression of rank on points with state and year fixed effects
*					iv.	Output all regressions to excel using Estout (a package you will need to install)
*
*
* 
*******************************************************************************/
 
/********************** Section 1: Preliminaries ******************************/

version 12.1
clear all
clear mata
set more off
cap log close

local input_dir  "$repository\analysis\input"
local temp_dir   "$repository\analysis\temp"
local output_dir "$repository\analysis\output"

log using "`temp_dir'/regressions", text replace

/********************** Section 2: regressions *************************/

use "`input_dir'\clean.dta", clear
eststo: reg rank points
eststo: reg rank points i.home_state_factor
eststo: reg rank points i.home_state_factor i.competition_year
esttab
label list statelbl

/********
* Save *
********

cd "`output_dir'"
save "section_count.dta", replace

log close
