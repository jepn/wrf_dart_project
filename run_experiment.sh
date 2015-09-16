#!/bin/bash
name_list_dir=/glade/u/home/jnini/tools/WRF_SCRIPTS/wrf_namelists/
wrf_name_list_dart="$name_list_dir"namelist_wrf_dart.input
wrf_name_list_pure="$name_list_dir"namelist_wrf_pure.input
wrf_out_dir=/glade/scratch/jnini/DOE_MBL-SE/WRF_forecast
echo $wrf_name_list_pure
start_date=200610010000
run_hours=24
#loop over all days 
 for d in {8..13}; do
   	ddtg_start=`echo $start_date  "$d"d -f ccyymmddhhnn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
            echo starting at $ddtg_start
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
        sed -i "/.*start_month.*/c\ start_month                         = $mm, $mm, $mm, $mm, $mm,"  $wrf_name_list_dart
        sed -i "/.*start_month.*/c\ start_month                         = $mm, $mm, $mm, $mm, $mm," $wrf_name_list_pure
        sed -i "/.*start_day.*/c\ start_day                           = $dd, $dd, $dd, $dd, $dd,"  $wrf_name_list_dart
        sed -i "/.*start_day.*/c\ start_day                           = $dd, $dd, $dd, $dd, $dd," $wrf_name_list_pure
        sed -i "/.*start_hour.*/c\ start_hour                          = $HH, $HH, $HH, $HH, $HH," $wrf_name_list_dart
        sed -i "/.*start_hour.*/c\ start_hour                          = $HH, $HH, $HH, $HH, $HH," $wrf_name_list_pure

#Advance the time and set end dates 

          ddtg_end=`echo $start_date  "$d"d"$run_hours"h -f ccyymmddhhnn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
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
        sed -i "/.*end_month.*/c\ end_month                           = $mm, $mm, $mm, $mm, $mm," $wrf_name_list_dart
        sed -i "/.*end_month.*/c\ end_month                           = $mm, $mm, $mm, $mm, $mm," $wrf_name_list_pure
        sed -i "/.*end_day.*/c\ end_day                             = $dd, $dd, $dd, $dd, $dd," $wrf_name_list_dart
        sed -i "/.*end_day.*/c\ end_day                             = $dd, $dd, $dd, $dd, $dd," $wrf_name_list_pure
        sed -i "/.*end_hour.*/c\ end_hour                            = $HH, $HH, $HH, $HH, $HH," $wrf_name_list_dart
        sed -i "/.*end_hour.*/c\ end_hour                            = $HH, $HH, $HH, $HH, $HH,"  $wrf_name_list_pure
                                                                                                                                           
#adjust timecontrol in namelist 
# submit job and waits until it is done  
	wrf_date=`echo $start_date "$d"d"0"h -f ccyy-mm-dd_hh:nn | /glade/scratch/jnini/DOE_MBL-SE/WRF-DART/ZNT_Charnock/advance_time`
	echo $wrf_date
# make sure taht all old stuff is removed before running 
	./clean_output_files.sh
	 ./runreal_vattenfall_2.sh $wrf_date
	# submit pure wrf job and waits until it is done  
	./runwrf_vattenfall.sh
	./runwrf_dart_vattenfall.sh $wrf_date
 
# then copy output to seperate folder 
#mv $wrf_out_dir/*wrfinput* $wrf_out_dir/wrfinput 
done





