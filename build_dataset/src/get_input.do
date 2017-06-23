clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
local files : dir "C:\Users\Chong An\Documents\GitHub\stata_practice\data" files "*.csv"
cd "C:\Users\Chong An\Documents\GitHub\stata_practice\data"
foreach file in `files'{
	copy "`file'" "C:\Users\Chong An\Documents\GitHub\stata_practice\build_dataset\input\\`file'", replace
	}
