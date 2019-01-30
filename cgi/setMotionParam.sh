#! /bin/bash
echo -e "Content-type: text/html\n\n"

echo "<!-- QUERY_STRING : ${QUERY_STRING} -->"
saveIFS=$IFS
IFS='=&'
params=($QUERY_STRING)
IFS=$saveIFS
motionParam=${params[0]}
motionParamValue=${params[1]}

echo "<!-- Param : '${motionParam}', Value : '${motionParamValue}' -->"
if [[ ( "{$motionParam}" == ""  || "{$motionParamValue}" == "" ) ]] ; then
  exit -1
fi

result=$(/home/pi/motion/FicusMAdmin.sh -s "${motionParam}" "${motionParamValue}")
echo "${motionParamValue}"
