clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
local files : dir "$repository/data" files "*.csv"
cd "$repository/data"
shell cp * ../build_dataset/input
