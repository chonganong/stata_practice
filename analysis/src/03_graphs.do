/*******************************************************************************
*	File name:		03_graphs.do
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

local input_dir  "$repository/analysis/input"
local temp_dir   "$repository/analysis/temp"
local output_dir "$repository/analysis/output"

cd "`temp_dir'"
log using "03_graphs", text replace

/********************** Section 2: graphs *************************/

cd "`input_dir'"
use "clean.dta", clear
histogram home_state_factor, discrete 
label list statelbl

cd "`output_dir'"
graph export "`output_dir'\histogram_state.png", replace
// use the graph export commanda
