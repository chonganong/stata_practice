clear all
clear mata
set more off
cap log close
//Remove folder if exists:
foreach folder in output input temp {
	cd "$repository/analysis"
	shell rm -rf "`folder'"
	mkdir `folder'
}

//run all files in folder
foreach file in get_input 01_summary_stats 02_regressions {
	cd "$repository//analysis/src/"
	do "`file'".do
}
