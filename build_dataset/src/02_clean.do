/*******************************************************************************
*	File name:		02_clean.do
*  	Author(s):		Chong An Ong
*  	Written:       	06/23/2017 (of latest version)
*
*	Inputs:			master_list.dta
*	Outputs:		clean.dta
*	
*	Description:	i.	Keep only Competition Month, Competition Year, Home City, Home State, Points, Rank
*					ii.	Clean “Competition Month”
*					iii.	Clean “Home State” to be a factor variable with a level for each state, a level for US territories, a level for Foreign. 
*					iv.	Generate an indicator variable for if the child’s home town has the word “Hill”
*					v.	Generate a variable which is the mean points by home state
*					vi.	Generate a variable which is the count of how many times each section appears
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

local input_dir  "$repository/build_dataset/input"
local temp_dir   "$repository/build_dataset/temp"
local output_dir "$repository/build_dataset/output"

cd "`temp_dir'"
shell chmod 777 .
log using "02_clean", text replace

/********************** Section 2: Remove unwanted variables *************************/

cd "`input_dir'"
use "master_list.dta", clear
keep competition_month competition_year home_city home_section home_state points rank

/********************** Section 3: Clean competition month ******************************/

//Not sure what to clean here since it already looks clean

/********************** Section 3: Generate home state factor variable ******************************/

replace home_state="GU" if home_city=="Guam"
replace home_state=upper(home_state)
replace home_state="Foreign" if length(home_state)!=2
// tab and scroll through to catch irregularities
replace home_state="Foreign" if home_state=="AB" | home_state=="BC" | home_state=="CZ" | home_state=="ON" | home_state=="PQ" | home_state=="QC" | home_state=="ZH"
replace home_state="Territory" if home_state=="AS" | home_state=="GU" | home_state=="MP" | home_state=="PR" | home_state=="UM" | home_state=="VI"
encode home_state, gen(home_state_factor) label(statelbl)
drop home_state
 
/********************** Section 4: Generate hill indicator variable ******************************/

gen hill_indicator=0
replace hill_indicator=1 if regexm(home_city, "Hill")==1 | (regexm(home_city, "hill")==1 & home_city!="Chillicothe")
// regexm can capture Hill, hill, etc. more direct

/********************** Section 5: Generate home state mean points variable ******************************/

egen home_state_mean=mean(points), by(home_state_factor)

/********************** Section 6: Generate section count variable ******************************/

encode home_section, gen(home_section_factor)
egen section_count=count(home_section_factor), by(home_section_factor competition_year)
drop home_section_factor
// best practice to have just one version per variable so all changes get tracked

********
* Save *
********

cd "`output_dir'"
save "`output_dir'/clean.dta", replace
// combine the cd and saving into one line by specifying file path
