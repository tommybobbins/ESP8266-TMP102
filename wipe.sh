#!/bin/bash
PORT=$1
if [ -e ${PORT} ]
then
  while true
    do
      luatool.py --port ${PORT} -w -r
      sleep 0.1
    done
else 
   echo "Unable to find the USB connection"
   exit 2
fi
