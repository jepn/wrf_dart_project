#!/bin/bash

ens_nr="10"
ddtg=2006100100
yyyy=".2006"
mm="-10"
dd="-08_"
HH="12:"
MM="00"
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
met_em_dir_d1=/glade/p/ral/nsap/doe_mpbl/FINO1/WRF/DART_input/met_em/D01/
met_em_dir_d2=/glade/p/ral/nsap/doe_mpbl/FINO1/WRF/DART_input/met_em/D02/
wrf_exe_dir=/glade/u/home/jnini/programs/WRF-ARW_v3.5.1_CZIL-DART_mods/run

output_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast/wrfinput/D02/
wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
filter_out_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/FILTER_OUTPUT/$ens_nr
wrf_namelist_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists
# get the dart namelist copy to current directory
#find /glade/p/ral/nsap/doe_mpbl/FINO1/WRF/DART_input/met_em/D01/ -name '*d01*' -and -name '*.2006*' -and -name '*-10*' -and -name '*-06*' -and -name '*_04*'

# here we need to have a script that changes and updates the dates in wrf namelist 
# get the wrf namelist and copy to run dir

MET_EM_FILE=$( find $met_em_dir_d1 -name "*d01*" -and -name "*$yyyy*" -and -name "*$mm*" -and -name "*$dd*" -and -name "*$HH*" -and -name "*$MM*")
echo  find $met_em_dir_d1 -name "*d01*" -and -name "*$yyyy*" -and -name "*$mm*" -and -name "*$dd*" -and -name "*$HH*" -and -name "*$MM*"
	echo $MET_EM_FILE
exit	# copy domaine_1 to current dir and rename 
	cp $MET_EM_FILE $wrf_run_dir
	MET_EM_FILE=$( find $met_em_dir_d2 -name "*d02*" -and -name "*$yyyy*" -and -name "*$mm*" -and -name "*$dd*" -and -name "*$HH*" -and -name "*$MM*")
        echo $MET_EM_FILE
        # copy domaine_1 to current dir and rename 
        cp $MET_EM_FILE $wrf_run_dir
cp runreal_vattenfall.csh $wrf_run_dir
cd $wrf_run_dir
bsub<runreal_vattenfall.csh 

#clean up

