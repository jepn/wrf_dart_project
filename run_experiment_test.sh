#!/bin/bash
name_list_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists/
wrf_name_list_dart="$name_list_dir"namelist_wrf_dart.input
wrf_name_list_pure="$name_list_dir"namelist_wrf_pure.input
echo $wrf_name_list_pure
start_date=200610010000
run_hours=24
#loop over all days 
 for d in {0..29}; do
   	ddtg=`echo $start_date  "$d"d -f ccyymmddhhnn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo starting at $ddtg
 	yy=`echo $start_date  "$d"d -f ccyy | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $yy
	 mm=`echo $start_date  "$d"d -f mm | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $mm
	dd=`echo $start_date  "$d"d -f dd | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $dd
	HH=`echo $start_date  "$d"d -f hh | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $HH
	MM=`echo $start_date  "$d"d -f nn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $MM
	#cat $wrf_name_list_pure | sed  "s/.*start_day.*/ start_day                          = testing, $HH, $HH, $HH, $HH,/" > "$name_list_dir"test_file_pure
	#cat $wrf_name_list_pure | sed  "s/.*start_day.*/ start_day                          = testing, $HH, $HH, $HH, $HH,/" > "$name_list_dir"test_file
	sed -i "/.*start_month.*/c\ start_month                         = $mm, $mm, $mm, $mm, $mm,"  "$name_list_dir"test_file
        sed -i "/.*start_month.*/c\ start_month                         = $mm, $mm, $mm, $mm, $mm," "$name_list_dir"test_file_pure
        sed -i "/.*start_day.*/c\ start_day                           = $dd, $dd, $dd, $dd, $dd,"  "$name_list_dir"test_file
        sed -i "/.*start_day.*/c\ start_day                           = $dd, $dd, $dd, $dd, $dd," "$name_list_dir"test_file_pure
        sed -i "/.*start_hour.*/c\ start_hour                          = $HH, $HH, $HH, $HH, $HH," "$name_list_dir"test_file
        sed -i "/.*start_hour.*/c\ start_hour                          = $HH, $HH, $HH, $HH, $HH," "$name_list_dir"test_file_pure
     
#Advance the time and set end dates 
 
	  ddtg=`echo $start_date  "$d"d"$run_hours"h"$run_hours"h -f ccyymmddhhnn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo ending at $ddtg
        yy=`echo $start_date  "$d"d"$run_hours"h -f ccyy | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $yy
         mm=`echo $start_date  "$d"d"$run_hours"h -f mm | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $mm
        dd=`echo $start_date  "$d"d"$run_hours"h -f dd | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $dd
        HH=`echo $start_date  "$d"d"$run_hours"h -f hh | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $HH
        MM=`echo $start_date  "$d"d"$run_hours"h -f nn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo $MM
        sed -i "/.*end_month.*/c\ end_month                           = $mm, $mm, $mm, $mm, $mm," "$name_list_dir"test_file
        sed -i "/.*end_month.*/c\ end_month                           = $mm, $mm, $mm, $mm, $mm," "$name_list_dir"test_file_pure
        sed -i "/.*end_day.*/c\ end_day                             = $dd, $dd, $dd, $dd, $dd," "$name_list_dir"test_file
        sed -i "/.*end_day.*/c\ end_day                             = $dd, $dd, $dd, $dd, $dd," "$name_list_dir"test_file_pure
        sed -i "/.*end_hour.*/c\ end_hour                            = $HH, $HH, $HH, $HH, $HH," "$name_list_dir"test_file
        sed -i "/.*end_hour.*/c\ end_hour                            = $HH, $HH, $HH, $HH, $HH,"  "$name_list_dir"test_file_pure

#	   ./runreal_vattenfall_2.sh $ddtg
exit
done

#./runreal_vattenfall_2.sh 200610081200




