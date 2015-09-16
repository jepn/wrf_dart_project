#!/bin/bash

ens_nr="10"
ddtg=2006100100
yyyy="_2006"
mm="-10"
dd="-08_"
HH="12:"
MM="00:"
SS="00_"


#time stuff 
#(`echo "${thisdate} 0 -g" | $rundir/advance_time`)
ddtg_greg=(`echo 2006100812 0 -g | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`)
echo ${ddtg_greg[1]}
#result_string="${original_string/Suzi/$string_to_replace_Suzi_with}"
#result_string="${test/ /_}"
# removing leading space
#echo ${test%% }
#echo "after replacing "$result_string

#replacing space with _

ddtg_greg_tag=`printf "%s_%s" ${ddtg_greg[0]} ${ddtg_greg[1]}`
echo "this tag "$ddtg_greg_tag

wrfbdy_files_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/WRF
dart_to_wrf_dir=/glade/u/home/jnini/tools/DART_SCRIPTS
dart_output_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/WRFOUT
output_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast/wrfinput/D02/
wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
filter_out_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/FILTER_OUTPUT/$ens_nr
wrf_namelist_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists
# get the dart namelist copy to current directory


# here we need to have a script that changes and updates the dates in wrf namelist 
# get the wrf namelist
cp $wrf_namelist_dir/namelist.input $wrf_run_dir/namelist.input

# get the wrf namelist first time else edit from run dir  
#cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp42/namelist.input $wrf_run_dir/namelist.input
# get all the TBL files first time 
cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp42/*TBL $wrf_run_dir
cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp42/RRTM* $wrf_run_dir
# set the wall tibe and other bsub varaibles here
cp runwrf_vattenfall.csh $wrf_run_dir

#produce one concatenated wrfbdy file do this only once out file i 3gb
	#ncrcat -h $wrfbdy_files_dir/wrfbdy_d01_* $wrf_run_dir/wrfbdy_d01

# get the wrf_output for ther correct date and rename it
# get correct file 

WRF_FILE=$( find $dart_output_dir -name "*d01*" -and -name "*$yyyy*" -and -name "*$mm*" -and -name "*$dd*" -and -name "*$HH*" -and -name "*$MM*" -and -name "*$SS*" -name "*$ens_nr")
	echo $WRF_FILE
	# copy domaine_1 to current dir and rename 
	cp $WRF_FILE $wrf_run_dir/wrf_input_d01
	WRF_FILE=$( find $dart_output_dir -name "*d02*" -and -name "*$yyyy*" -and -name "*$mm*" -and -name "*$dd*" -and -name "*$HH*" -and -name "*$MM*" -and -name "*$SS*" -name "*$ens_nr")
	echo $WRF_FILE
	cp $WRF_FILE $wrf_run_dir/wrf_input_d02


# copy the filter_out file 
#
	cp $filter_out_dir/dart_wrf_input_$ddtg_greg_tag.00$ens_nr $wrf_run_dir/dart_wrf_vector
#	cp $filter_out_dir/dart_wrf_input_148199_0.00$ens_nr $wrf_run_dir/dart_wrf_vector
	cp /glade/u/home/jnini/tools/DART_SCRIPTS/dart_to_wrf $wrf_run_dir
# copy the soil state files 
	cp $dart_output_dir/saveflds_$ens_nr/saveout_d01$yyyy$mm$dd$HH$MM$SS$ens_nr.nc $wrf_run_dir/soil_state_d01.nc
	cp $dart_output_dir/saveflds_$ens_nr/saveout_d02$yyyy$mm$dd$HH$MM$SS$ens_nr.nc $wrf_run_dir/soil_state_d02.nc
# add soils state to input file 
	ncks -A $wrf_run_dir/soil_state_d01.nc $wrf_run_dir/wrf_input_d01
	ncks -A $wrf_run_dir/soil_state_d02.nc $wrf_run_dir/wrf_input_d02

# run dart_to_wrf
cd $wrf_run_dir
./dart_to_wrf
#submit the sub 
bsub <runwrf_vattenfall.csh

#make all input files available in run dir 

#cp $wrf_input_dir/wrfout_d02*_$ens_nr $wrf_run_dir/wrfinput/D02


posterior_dir="pwd"
