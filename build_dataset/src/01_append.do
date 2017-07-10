/*******************************************************************************
*	File name:		01_append.do
*  	Author(s):		Chong An Ong
*  	Written:       	06/23/2017 (of latest version)
*
*	Inputs:			$repository\data
*	Outputs:		master_list.dta
*	
*	Description:    i.	Convert the .csv files into .dta files.
*					ii.	Append all of the .dta files into one.
*
* 
*******************************************************************************/
 
/********************** Section 1: Preliminaries ******************************/

version 12.1
clear all
clear mata
set more off
cap log close

local input_dir  "$repository/build_dataset/input"
local temp_dir   "$repository/build_dataset/temp"
local output_dir "$repository/build_dataset/output"

/********************** Section 2: Import raw data *************************/

local files : dir "`input_dir'/" files "*.csv"
cd "`input_dir'"
foreach file in `files'{
	insheet using "`file'", comma clear
	save "`temp_dir'//`file'.dta", replace
}

/********************** Section 3: Append data ******************************/

clear all
cd "`temp_dir'"
local files : dir "`temp_dir'/" files "*.dta"
foreach file in `files'{
	append using "`file'"
}
	
********
* Save *
********
cd "`input_dir'"
save "master_list.dta", replace

log close
