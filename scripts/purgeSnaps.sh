cd "$(dirname "$0")";
find ./snapshot -mtime +3 -exec rm {} \;
