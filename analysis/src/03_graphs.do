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

local input_dir  "$repository\analysis\input"
local temp_dir   "$repository\analysis\temp"
local output_dir "$repository\analysis\output"

log using "`temp_dir'\graphs", text replace

/********************** Section 2: graphs *************************/

use "`input_dir'\clean.dta", clear
histogram home_state_factor, discrete 
label list statelbl

cd "`output_dir'"
graph save Graph "C:\Users\Chong An\Documents\GitHub\stata_practice\analysis\output\histogram_state.gph"
