#! /bin/bash

cd "$(dirname "$0")";

CURRENT_SNAP_DIR=./snapshot/current
SNAP_DIR=./snapshot

for f in $(find $CURRENT_SNAP_DIR -type f) 
do
 echo "FileName : $f"
 fulldate=$(echo $f | cut -d'-' -f2)
 echo "FullDate : $fulldate"

 year=${fulldate:0:4}
 month=${fulldate:4:2}
 day=${fulldate:6:2}
 hour=${fulldate:8:2}
 echo "Year : $year, Month : $month, Day : $day, Hour : $hour"

 snapDir="${SNAP_DIR}/${year}/${month}/${day}/${hour}"
 mkdir -p $snapDir

 echo "Moving ${f} --> ${snapDir}"
 mv $f $snapDir

 echo 
done
