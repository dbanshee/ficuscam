#! /bin/bash

ficusAdminUrl="http://localhost:8080/0"
ficusAdminUrlSetParam="${ficusAdminUrl}/config/set?"


motion_listOptions() {
  url="${ficusAdminUrl}/config/list"
  options=$(wget -qO- $url)
  echo $options
}

motion_takeSnapShot() {
  url="${ficusAdminUrl}/action/snapshot"
  echo $url
  wget -qO- $url
}

motion_changeAutoSnaps() {
  mode=$1
  
  if [[ ( $mode == 0 ) ]] ; then
    intervalSecs="0"
  else 
    intervalSecs="600"
  fi
  
  url="${ficusAdminUrlSetParam}snapshot_interval=${intervalSecs}"
  wget -qO-$url
}

#Main
case "$1" in
	"") 
          echo "Usage: $0 [--listMotionOptions|-l] [--takeSnapShot] [--enableDisableAutoSnaps]"
          exit -1
	;;
	--listMotionOptions|-l)
          motion_listOptions;
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
