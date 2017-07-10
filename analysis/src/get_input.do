clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
cd "$repository/build_dataset/output"
shell cp * "$repository/analysis/input"
