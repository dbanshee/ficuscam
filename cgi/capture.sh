#!/bin/bash
echo -e "Content-type: text/html\n\n"
echo "Hello World"
echo ">> QUERY_STRING : ${QUERY_STRING}"
read REQUEST_BODY
echo ">> REQUEST_BODY : ${REQUEST_BODY}"


saveIFS=$IFS
IFS='=&'
params=($QUERY_STRING)
IFS=$saveIFS

echo "List elem : ${params[1]}"

#uvccapture -m -v -x640 -y480 -S20 -C25 -G40 -B20 -o/home/pi/apache/snap.jpg
#echo -e "Content-type: image/jpeg\n"
#cat /home/pi/apache/snap.jpg
#echo `whoami`
