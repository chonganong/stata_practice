clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
cd "C:\Users\Chong An\Documents\GitHub\stata_practice\build_dataset\output"
copy clean.dta "C:\Users\Chong An\Documents\GitHub\stata_practice\analysis\input\clean.dta", replace
