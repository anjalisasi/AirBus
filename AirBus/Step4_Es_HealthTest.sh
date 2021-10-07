#!/bin/bash

# AirBus Task 
# Author-> Anjali Sasidharan 
# This  runs a python based health check of ES 

echo "Starting the Heatlth  Test for the ES docker container"


host=`grep server_name  /home/ansible/AirBus/inventory/group_vars/prod/vars.yml`
host=`echo $host | awk -F': ' '{print $NF}'`

password=`grep elastic_password  /home/ansible/AirBus/inventory/group_vars/prod/vars.yml`
password=`echo $password | awk -F': ' '{print $NF}'`
password=`echo $password | sed 's/"//g'`
username="elastic"


python -W ignore::DeprecationWarning es-health-test.py  --es_address $host \
        --username $username \
        --password $password

