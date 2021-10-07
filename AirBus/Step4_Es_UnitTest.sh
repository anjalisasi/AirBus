#!/bin/bash

# AirBus Task 
# Author-> Anjali Sasidharan 
# This  runs a python based unit test of ES 


figlet -c "AirBus : Unit test "

rm -rf  /tmp/tempfile

host=`grep server_name /home/ansible/AirBus/inventory/group_vars/prod/vars.yml`
host=`echo $host | awk -F': ' '{print $NF}'`

password=`grep elastic_password /home/ansible/AirBus/inventory/group_vars/prod/vars.yml`
password=`echo $password | awk -F': ' '{print $NF}'`
password=`echo $password | sed 's/"//g'`
username="elastic"



port=`grep ELASTICSEARCH_HOSTS /home/ansible/AirBus/roles/kibana/tasks/main.yml`
port=`echo $port | awk -F'}:' '{print $NF}'`
port=`echo $port | sed 's/"//g'`

echo $host >> /tmp/tempfile
echo $password >>  /tmp/tempfile 
echo $port >> /tmp/tempfile 


python -W ignore::DeprecationWarning es-unit-test.py 

rm -rf  /tmp/tempfile

