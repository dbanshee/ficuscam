#! /bin/bash
echo -e "Content-type: text/html\n\n"

#echo "<!-- QUERY_STRING : ${QUERY_STRING} -->"
saveIFS=$IFS
IFS='=&'
params=($QUERY_STRING)
IFS=$saveIFS
motionParam=${params[1]}

#echo "<!-- Param : '${motionParam}' -->"
if [[ ( "{$motionParam}" == "" ) ]] ; then
  exit -1
fi

paramValue=$(/home/pi/motion/FicusMAdmin.sh -g "$motionParam")
echo "${paramValue}"
