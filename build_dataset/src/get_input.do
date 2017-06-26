clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
local files : dir "$repository\data" files "*.csv"
cd "$repository\data"
foreach file in `files'{
	copy "`file'" "$repository\build_dataset\input\\`file'", replace
}
