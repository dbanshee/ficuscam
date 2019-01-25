#! /bin/bash


OLD_SNAP_DIR=./snapshot
NEW_SNAP_DIR=./new_snapshot

mkdir -p $NEW_SNAP_DIR



for f in $(find $OLD_SNAP_DIR -type f) 
do
 echo "FileName : $f"
 fulldate=$(echo $f | cut -d'-' -f2)
 echo "FullDate : $fulldate"

 year=${fulldate:0:4}
 month=${fulldate:4:2}
 day=${fulldate:6:2}
 hour=${fulldate:8:2}
 echo "Year : $year, Month : $month, Day : $day, Hour : $hour"

 snapDir="${NEW_SNAP_DIR}/${year}/${month}/${day}/${hour}"
 mkdir -p $snapDir

 echo "Copiando ${f} --> ${snapDir}"
 cp $f $snapDir

 echo 
done
