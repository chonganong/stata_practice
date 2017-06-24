clear all
clear mata
set more off
cap log close

//Remove folder if exists:
foreach folder in output input temp {
	cd "$repository/build_dataset/"
	cap !rmdir `folder' /s /q
	mkdir `folder'
}

//run all files in folder
foreach file in get_input 01_append 02_clean {
	cd "$repository//build_dataset/src/"
	do "`file'".do
}
