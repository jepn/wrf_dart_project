#!/bin/csh
#
# LSF batch script to run the test MPI code
#
#BSUB -P xxxxxxxx                       # Project 99999999
#BSUB -a poe                            # select poe
#BSUB -x                                # exclusive use of node (not_shared)
#BSUB -n 32                             # number of total (MPI) tasks
#BSUB -R "span[ptile=32]"               # run a max of 32 tasks per node
#BSUB -J real                           # job name
#BSUB -o real%J.out                     # output filename
#BSUB -e real%J.err                     # error filename
#BSUB -W 0:30                           # wallclock time
#BSUB -q regular                        # queue
#
cd /glade/p/work/$USER/WPS_DIRECTORY
mpirun.lsf ./metgrid.exe
exit
