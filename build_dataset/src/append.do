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

log using "`temp_dir'/append", text replace

/********************** Section 2: Import raw data *************************/

local files : dir "`input_dir'\" files "*.csv"
cd "`input_dir'"
foreach file in `files'{
	insheet using "`file'", comma clear
	save "`file'.dta", replace
	}

/********************** Section 3: Append data ******************************/

clear all
local files : dir "`input_dir'\" files "*.dta"
foreach file in `files'{
	append using "`file'"
	}
	
********
* Save *
********

save "master_list.dta", replace

log close
