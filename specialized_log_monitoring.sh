# Requirement: We have 3 WebSphere application servers which logs needs to be monitored.
# We had a constraint that we can only get the logs from a Citrix Jumpbox (Windows 10)
# and we are not allowed to install anything on that VM.
# This script will download the log files every approx. 2min
# and the log files are opened for monitoring in a portable log viewer 'baretail'

#!/bin/sh

target=$1
pw=$2

if [ "$target" = "app1" ]
then
	IP='192.168.254.1'
	APPSERVER_NAME='appserver_1'
elif [ "$target" = "app2" ]
then
	IP='192.168.254.2'
	APPSERVER_NAME='appserver_2'
elif [ "$target" = "app3" ]
then
	IP='192.168.254.3'
	APPSERVER_NAME='appserver_3'
fi

echo $IP $APPSERVER_NAME

WAS_LOG_SRC_DIR="/opt/IBM/WebSphere/<profile_path>/$APPSERVER_NAME/logs/$APPSERVER_NAME"
WAS_LOG_FILE="SystemOut.log"
APPS_LOG_SRC_DIR="/opt/IBM/WebSphere/logs"
APP1_LOG_FILE="app1*.log"
APP2_LOG_FILE="app2*.log"
DEST="/c/Users/elogs/Documents/logs"

for i in {1..200}; do if (( $i % 5 == 0)); then rm $DEST/$WAS_LOG_FILE $DEST/$APP1_LOG_FILE; sleep 5; fi; \
yes| pscp -pw $pw root@$IP:$WAS_LOG_SRC_DIR/$WAS_LOG_FILE $DEST; \
yes| pscp -pw $pw root@$IP:$APPS_LOG_SRC_DIR/$APP1_LOG_FILE $DEST; \
yes| pscp -pw $pw root@$IP:$APPS_LOG_SRC_DIR/$APP2_LOG_FILE $DEST; \
echo -ne "Iter $i $(date)" ; \
sleep 150; done

