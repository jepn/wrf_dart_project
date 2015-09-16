#!/bin/csh
#
# LSF batch script to run the test MPI code
#
##BSUB -P NSAP0002
##BSUB -J ADVANCE
##BSUB -o ADVANCE.o.%J
##BSUB -e ADVANCE.e.%J
##BSUB -q regular
##BSUB -n 16
##BSUB -R "span[ptile=16]"
##BSUB -W 0:20

#BSUB -P NSAP0002
#BSUB -J wrf_dart
#BSUB -o wrf_dart.o.%J
#BSUB -e vrf_dart.e.%J
#BSUB -q regular
#BSUB -n 16
#BSUB -R "span[ptile=16]"
#BSUB -W 2:00

#source /usr/local/lsf/conf/cshrc.lsf


#set wrf_input_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast/DART_input
set wrf_exe_dir=/glade/u/home/jnini/programs/WRF-ARW_v3.5.1_CZIL-DART_mods/run
#make all input files available in run dir 

#cp $wrf_input_dir/wrfout_d02*_$ens_nr $wrf_run_dir/wrfinput/D02
# next is to rename wrfout to wrfinput
#
#

#source /usr/local/lsf/conf/cshrc.lsf
#
#
#cd /glade/p/work/$USER/WRF_DIRECTORY
#
#unsetenv MP_COREFILE_FORMAT
#
# the following needs to be done once
#mpirun.lsf ./wrf.exe
mpirun.lsf /glade/u/home/jnini/programs/WRF-ARW_v3.5.1_CZIL-DART_mods/run/wrf.exe
#
#clean up all linked files 

exit
