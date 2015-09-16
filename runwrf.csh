#!/bin/csh
#
# LSF batch script to run the test MPI code
#


#BSUB -P NSAP0002
#BSUB -J vrd_fino
#BSUB -o vrd_fino.o.%J
#BSUB -e vrd_fino.e.%J
#BSUB -q regular
#BSUB -n 16
#BSUB -R "span[ptile=16]"
#BSUB -W 1:20
set ens_nr=10
set ddtg=2006100100
set wrf_run_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast 
#set wrf_input_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast/DART_input
set wrf_input_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/WRFOUT
set wrf_exe_dir=/glade/u/home/jnini/programs/WRF-ARW_v3.5.1_CZIL-DART_mods/run
#make all input files available in run dir 

#cp $wrf_input_dir/wrfout_d02*_$ens_nr $wrf_run_dir/wrfinput/D02
# next is to rename wrfout to wrfinput
#
#

rename wrfout wrf_input $wrf_run_dir/wrfinput/D02/*


#
#
exit
#cp $wrf_input_dir/met_em/D01/met_em.d01.2006-10-12_14* $wrf_run_dir
#cp $wrf_input_dir/met_em/D02/met_em.d02.2006-10-12_14* $wrf_run_dir
#cp $wrf_input_dir/met_em/D03/met_em.d03.2006-10-12_14* $wrf_run_dir
exit
cp -s $wrf_input_di/met_eem/D02/* $wrf_run_dir 
exit


#source /usr/local/lsf/conf/cshrc.lsf
#
#
cd $wrf_run_dir
#cd /glade/p/work/$USER/WRF_DIRECTORY
#
#unsetenv MP_COREFILE_FORMAT
#
# the following needs to be done once
#mpirun.lsf ./wrf.exe
mpirun.lsf $wrf_exe_dir/wrf.exe
#
#clean up all linked files 
rm $wrf_run_dir/met_em*

exit
