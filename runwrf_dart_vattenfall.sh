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
ddtg_greg=(`echo $1 0 -g | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`)
wrf_date=`echo $1 "$d"d"0"h -f ccyy-mm-dd_hh:nn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
echo ${ddtg_greg[1]}
#result_string="${original_string/Suzi/$string_to_replace_Suzi_with}"
#result_string="${test/ /_}"
# removing leading space
#echo ${test%% }
#echo "after replacing "$result_string

#replacing space with _

ddtg_greg_tag=`printf "%s_%s" ${ddtg_greg[0]} ${ddtg_greg[1]}`
echo "this tag "$ddtg_greg_tag
 	ddtg_start=`echo $1  "$d"d -f ccyymmddhhnn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo starting at $ddtg_start
        yyyy=`echo $ddtg_start  "$d"d -f ccyy | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $yyyy
         mm=`echo $ddtg_start  "$d"d -f mm | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $mm
        dd=`echo $ddtg_start  "$d"d -f dd | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $dd
        HH=`echo $ddtg_start  "$d"d -f hh | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $HH
        MM=`echo $ddtg_start  "$d"d -f nn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $MM
wrfbdy_files_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/WRF
dart_to_wrf_dir=/glade/u/home/jnini/tools/DART_SCRIPTS
dart_output_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/WRFOUT
output_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast/wrfinput/D02/
wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
filter_out_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/FILTER_OUTPUT/$ens_nr
wrf_namelist_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists

# get the dart namelist copy to current directory
# here we need to have a script that changes and updates the dates in wrf namelist 
# get the wrf namelist that outputs the right places, ddtg should be set - copy to run dir
cp $wrf_namelist_dir/namelist_wrf_dart.input $wrf_run_dir/namelist.input
# get the wrf namelist first time else edit from run dir  
#cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp42/namelist.input $wrf_run_dir/namelist.input
# get all the TBL files first time 
cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp$ens_nr/*TBL $wrf_run_dir
cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp$ens_nr/RRTM* $wrf_run_dir
cp /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_temp$ens_nr/wrflowinp* $wrf_run_dir
# set the wall tibe and other bsub varaibles here
cp runwrf_dart_vattenfall.csh $wrf_run_dir

#produce one concatenated wrfbdy file do this only once out file i 3gb
	#ncrcat -h $wrfbdy_files_dir/wrfbdy_d01_* $wrf_run_dir/wrfbdy_d01

# get the wrf_output for ther correct date and rename it
# get correct file 

WRF_FILE=$( find $dart_output_dir -name "*d01*" -and -name "*$wrf_date*" -and  -name "*$ens_nr")
echo find $dart_output_dir -name "*d01*" -and -name "*$wrf_date*" -and  -name "*$ens_nr"
	echo $WRF_FILE
	# copy domaine_1 to current dir and rename 
if  [ -n "$WRF_FILE" ]
then
echo found output files executing wrf and dart
	cp $WRF_FILE $wrf_run_dir/wrfinput_d01
	WRF_FILE=$( find $dart_output_dir -name "*d02*" -and -name "*$wrf_date*" -and -name "*$ens_nr")
	echo $WRF_FILE
# logic is here that if the wrf out files exists then the dart files exists also and it make sense to doa wrf run 
	# copy fresh input file 
		cp $WRF_FILE $wrf_run_dir/wrfinput_d02
	# copy the filter_out file 
		cp $filter_out_dir/dart_wrf_input_$ddtg_greg_tag.00$ens_nr $wrf_run_dir/dart_wrf_vector
	#	cp $filter_out_dir/dart_wrf_input_148199_0.00$ens_nr $wrf_run_dir/dart_wrf_vector
		cp /glade/u/home/jnini/tools/DART_SCRIPTS/dart_to_wrf $wrf_run_dir
	# copy the soil state files but only if no wrfout files is present - one could delete all wrf files and only use soil state files to save storage space 
	# 
 
		#cp $dart_output_dir/saveflds_$ens_nr/saveout_d01$wrf_date"_"$ens_nr.nc $wrf_run_dir/soil_state_d01.nc
		#cp $dart_output_dir/saveflds_$ens_nr/saveout_d02$wrf_date"_"$ens_nr.nc $wrf_run_dir/soil_state_d02.nc
	# add soils state to input file 
		#ncks -A $wrf_run_dir/soil_state_d01.nc $wrf_run_dir/wrf_input_d01
		#ncks -A $wrf_run_dir/soil_state_d02.nc $wrf_run_dir/wrf_input_d02
	# run dart_to_wrf
	cd $wrf_run_dir
		#data assimilation trick
		./dart_to_wrf
	#submit the job and get job id and status 
		jobid_long=`bsub <runwrf_dart_vattenfall.csh`
	   	jobid=`echo $jobid_long | awk '{FS="Job"} {print $2}' | awk '{print substr($0, 2, length($0) - 2)}'`
	        jobs_status_long=`bjobs -u jnini`
	# get the run status
	        job_status=`echo $jobs_status_long  | awk -F' ' '{print $11}'`
	        echo jobstaus is $job_status
 	       echo jobid is: $jobid
	# quit only when jobs done 
	   while [[  "$job_status" == "RUN" ]] || [[ "$job_status" == "PEND" ]]
	    do
   	       echo jobs running getting new status
   	             jobs_status_long=`bjobs -u jnini`
        	        job_status=`echo $jobs_status_long  | awk -F' ' '{print $11}'`
                	echo dart jobstaus is $job_status
               		echo dart jobid is: $jobid
          	        echo wainting 1/2 hour
                	sleep 30m
     	    done
else
	echo no file output files found 
fi
#make all input files available in run dir 
#cp $wrf_input_dir/wrfout_d02*_$ens_nr $wrf_run_dir/wrfinput/D02


