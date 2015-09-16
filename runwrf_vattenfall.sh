#!/bin/bash
wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
filter_out_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/FILTER_OUTPUT/$ens_nr
wrf_namelist_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists


cp $wrf_namelist_dir/namelist_wrf_pure.input $wrf_run_dir/namelist.input

cp runwrf_vattenfall.csh $wrf_run_dir

cd $wrf_run_dir
#submit the sub 


              jobid_long=`bsub <runwrf_vattenfall.csh`
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
                        echo jobstaus is $job_status
                        echo jobid is: $jobid
                        echo wainting 1/2 hour on wrf job
                        sleep 30m

		done

#cp $wrf_input_dir/wrfout_d02*_$ens_nr $wrf_run_dir/wrfinput/D02

