#!/bin/bash

urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

#chroot /var/www/ << EOF
echo -e "Content-type: text/html\n\n"
#echo "Hello World"
#echo ">> QUERY_STRING : ${QUERY_STRING}"
#read REQUEST_BODY
#echo ">> REQUEST_BODY : ${REQUEST_BODY}"
#saveIFS=$IFS
#IFS='=&'
#params=($QUERY_STRING)
#IFS=$saveIFS
#echo "List elem : ${params[1]}"

read REQUEST_BODY
saveIFS=$IFS
IFS='=&'
params=($REQUEST_BODY)
IFS=$saveIFS
dir=${params[1]}
#dir="${dir/\%2F/}"i
dir=$(urldecode "$dir")
echo "<!-- dir : $dir-->"

# Mejor con chroot
if [[ $dir == *'..'* ]]; then
  echo "ERROR '..' not allowed"
  exit -1
fi

ROOT_SNAPSHOTS=/home/pi/motion/snapshot
DIR="${ROOT_SNAPSHOTS}/${dir}"
echo "<!--$DIR-->"

echo "<ul class=\"jqueryFileTree\" style=\"\">"

prefix="$dir/"
if [[ $dir == '.' ]]; then
  prefix=""
fi

echo "<!-- prefix : ${prefix} -->"

for dirName in $(find $DIR -maxdepth 1 -type d -printf '%P\n' | sort -n -r)
do
  echo "<li class=\"directory collapsed\"><a href=\"#\" rel=\"${prefix}$(basename ${dirName})/\">$(basename ${dirName})</a></li>"
done

for fileName in $(find $DIR -maxdepth 1 -type f -printf '%P\n' | sort -n -r)
do
  echo "<li class=\"file collapsed\"><a href=\"#\" rel=\"./snapshot/${prefix}$(basename ${fileName})\">$(basename ${fileName})</a></li>"
        
done
echo "</ul>"
