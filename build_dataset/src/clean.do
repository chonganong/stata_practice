/*******************************************************************************
*	File name:		clean.do
*  	Author(s):		Chong An Ong
*  	Written:       	06/23/2017 (of latest version)
*
*	Inputs:			
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

local input_dir  "C:\Users\Chong An\Documents\GitHub\stata_practice\build_dataset\input"
local temp_dir   "C:\Users\Chong An\Documents\GitHub\stata_practice\build_dataset\temp"
local output_dir "C:\Users\Chong An\Documents\GitHub\stata_practice\build_dataset\output"

log using "`temp_dir'/clean", text replace

/********************** Section 2: Remove unwanted variables *************************/

use "`input_dir'\master_list.dta", clear
keep competition_month competition_year home_city home_state points rank

/********************** Section 3: Clean competition month ******************************/

//Not sure what to clean here since it already looks clean

/********************** Section 3: Generate home state factor variable ******************************/

replace home_state=upper(home_state)
replace home_state="Foreign" if length(home_state)!=2
replace home_state="Foreign" if home_state=="AB" | home_state=="BC" | home_state=="CZ" | home_state=="ON" | home_state=="PQ" | home_state=="QC" | home_state=="ZH"
replace home_state="Territory" if home_state=="AS" | home_state=="GU" | home_state=="MP" | home_state=="PR" | home_state=="UM" | home_state=="VI"
egen home_state_factor=group(home_state),label
drop home_state
 
/********************** Section 4: Generate hill indicator variable ******************************/

gen hill_indicator=0
replace hill_indicator=1 if strpos(home_city, "Hill")>0

/********************** Section 5: Generate home state mean points variable ******************************/

egen home_state_mean=mean(points), by(home_state_factor)

/********************** Section 6: Generate state count variable ******************************/

egen state_count=count(home_state_factor), by(home_state_factor)

********
* Save *
********

cd "`output_dir'"
save "clean.dta", replace

log close
