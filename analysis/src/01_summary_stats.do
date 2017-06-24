/*******************************************************************************
*	File name:		01_summary_stats.do
*  	Author(s):		Chong An Ong
*  	Written:       	06/23/2017 (of latest version)
*
*	Inputs:			clean.dta
*	Outputs:		section_count.dta
*	
*	Description:    i.	T.Test of whether kids who live in towns with Hill in the name are better or worse than kids do not live in such a town.
*					ii.	Output a table of the number of kids from each state.  
*					iii.	Output a table of the 10 most common cities each year (one column for each year, row 1 is the most common city that year, row 2 second most common, etc.).  
*					iv.	Use duplicates drop and reshape to save a dataset which gives the count of home many times each section appears by year in a wide form. 
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

log using "`temp_dir'/summary_stats", text replace

/********************** Section 2: t-test on points by hill indicator *************************/

use "`input_dir'\clean.dta", clear
ttest points, by(hill_indicator)

/********************** Section 3: Output table of number of kids from each state ******************************/

tab home_state_factor
 
/********************** Section 4: Output table of 10 most common cities each year ******************************/

encode home_city, gen(home_city_factor)
egen home_city_count=count(home_city_factor), by(home_city_factor competition_year)
forvalues year=2004/2015 {
	preserve
		keep if competition_year==`year'
		gsort -home_city_count, gen(city_rank)
		duplicates drop home_city, force
		drop if city_rank > 10
		keep home_city city_rank
		rename home_city _`year'
		save "`temp_dir'\\`year'.dta", replace
	restore

}

/********************** Section 5: Output section-count by year wide dataset *******************************/

keep competition_year home_section section_count
duplicates drop
replace home_section="Mid_Atlantic" if home_section=="Mid-Atlantic"
reshape wide section_count, i(competition_year) j(home_section) s
gen Total=0
foreach var of varlist section* {
	replace `var'=0 if `var'==.
	replace Total=`var'+Total
	}
rename *count* .*


********
* Save *
********

cd "`output_dir'"
save "section_count.dta", replace

log close
