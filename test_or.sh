
#!/bin/bash
test=run
echo  $[ $test == run ]
while  [[  $job_status == "RUN" ]] || [[ $job_status == "PEND" ]]
        do 
        echo jobs running getting new status
                jobs_status_long=`bjobs -u jnini`
                job_status=`echo $jobs_status_long  | awk -F' ' '{print $11}'`
                echo jobstaus is $job_status
                echo jobid is: $jobid
                echo wainting 10 sec
                sleep 1s
     done
        echo real.exe done exiting 
        exit

