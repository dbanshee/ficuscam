#! /bin/bash

SNAPS_INTERVAL_SECS=600

ficusAdminUrl="http://localhost:8080/0"
#ficusAdminUrl="http://ficusillo.mooo.com:9080/0"
ficusAdminUrlSetParam="${ficusAdminUrl}/config/set?"

motion_getUrl() {
  url=$1
  response=$(wget -qO- $url)
  errorCode=$?
  if [[ ( $errorCode != 0) ]] ; then
    echo "Error in HTTP Request : ${errorCode}" >&2
    exit -1
  fi
  
  echo "$response"
}

motion_listParams() {
  url="${ficusAdminUrl}/config/list"
  params=$(motion_getUrl "$url")
  echo "$params"
}

motion_getParam() {
  param=$1
  url="${ficusAdminUrl}/config/get?query=${param}"
  response=$(motion_getUrl "$url")
  value=$(echo "$response" | grep -oP ".*${param} = \K(.*).*$")
  echo "$value"
}

motion_setParam() {
  param=$1
  value=$2
  url="${ficusAdminUrl}/config/set?${param}=${value}"
  response=$(motion_getUrl "$url")
  echo "$response"
}

motion_takeSnapShot() {
  url="${ficusAdminUrl}/action/snapshot"
  response=$(motion_getUrl "$url")
  echo $response
}

motion_changeAutoSnaps() {
  mode=$1
  
  if [[ ( $mode == 0 ) ]] ; then
    intervalSecs="0"
  else 
    intervalSecs="${SNAPS_INTERVAL_SECS}"
  fi
  
  url="${ficusAdminUrlSetParam}snapshot_interval=${intervalSecs}"
  wget -qO- $url
}

#Main
case "$1" in
	"") 
          echo "Usage: $0 [--listMotionParams|-l] [--getMotionParam|-g] [--takeSnapShot] [--enableDisableAutoSnaps]"
          exit -1
	;;
	--listMotionParams|-l)
          motion_listParams;
	;;
	--getMotionParam|-g)
          if [[ ( $# != 2 ) ]] ; then
            echo "Bad Request"
            exit -1
          fi
          motion_getParam $2;
        ;;
        --setMotionParam|-s)
          if [[ ( $# != 3 ) ]] ; then
            echo "Bad Request"
            exit -1
          fi
          motion_setParam $2 $3;
        ;;
        --takeSnapShot|-s)
          motion_takeSnapShot;
        ;;
	--enableDisableAutoSnaps)
          if [[ ( $# != 2 ) || ( "$2" != "0" && "$2" != "1" ) ]] ; then
            echo "Bad Request"
            exit -1
          fi

          motion_changeAutoSnaps $2;
	;;
esac
