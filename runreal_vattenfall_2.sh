#!/bin/bash

ens_nr="10"


wrfbdy_files_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/WRF
dart_to_wrf_dir=/glade/u/home/jnini/tools/DART_SCRIPTS
met_em_dir_d1=/glade/p/ral/nsap/doe_mpbl/FINO1/WRF/DART_input/met_em/D01/
met_em_dir_d2=/glade/p/ral/nsap/doe_mpbl/FINO1/WRF/DART_input/met_em/D02/
wrf_exe_dir=/glade/u/home/jnini/programs/WRF-ARW_v3.5.1_CZIL-DART_mods/run
wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
filter_out_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/FILTER_OUTPUT/$ens_nr
wrf_namelist_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists
	for h in {0..0}; do
            echo item: $h
		long=$1
		start_date=${long:0:10} # startdate is parsed from command line 
		echo $start_date 
		echo using date : $start_date
		MET_EM_FILE=$( find $met_em_dir_d1 -name "*d01*" -and -name "*$start_date*")
		echo find $met_em_dir_d1 -name "*d01*" -and -name "*$start_date*"
		echo $MET_EM_FILE
 # copy domaine_1 to current dir and rename 
	        cp $MET_EM_FILE $wrf_run_dir
		MET_EM_FILE=$( find $met_em_dir_d2 -name "*d02*" -and -name "*$start_date*")
		echo $MET_EM_FILE
 	       # copy domaine_2 to current dir and rename 
	     cp $MET_EM_FILE $wrf_run_dir
done
start_date=$1
cp $wrf_namelist_dir/namelist_wrf_pure.input $wrf_run_dir/namelist.input
cp runreal_vattenfall.csh $wrf_run_dir
cd $wrf_run_dir
	jobid_long=`bsub<runreal_vattenfall.csh` 
	jobid=`echo $jobid_long | awk '{FS="Job"} {print $2}' | awk '{print substr($0, 2, length($0) - 2)}'`
	jobs_status_long=`bjobs -u jnini`
# get the run status
	job_status=`echo $jobs_status_long  | awk -F' ' '{print $11}'`
	echo jobstaus is $job_status
	echo jobid is: $jobid
# quit only when jobs done 
   while  [[  "$job_status" == "RUN" ]] || [[ "$job_status" == "PEND" ]]
	do   
   	echo jobs running getting new status
	        jobs_status_long=`bjobs -u jnini`
        	job_status=`echo $jobs_status_long  | awk -F' ' '{print $11}'`
        	echo jobstaus is $job_status
        	echo jobid is: $jobid
		echo wainting 15 sec
		sleep 15s
     done 
	echo real.exe done exiting 
	exit 
  
#clean up
