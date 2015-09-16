#!/bin/bash

wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
#clean up

#rm $wrf_run_dir/met*
rm $wrf_run_dir/wrfout*
rm $wrf_run_dir/real_fino*
rm $wrf_run_dir/*fino*
rm $wrf_run_dir/wrfinput*
rm $wrf_run_dir/namelist*
