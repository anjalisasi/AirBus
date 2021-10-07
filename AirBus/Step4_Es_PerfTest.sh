#!/bin/bash

# AirBus Task 
# Stress test the ES docker instance created 
# Using python as outlines in the requirement
# Author-> Anjali Sasidharan 
# This script calls the python script es-perf-test.py 

figlet -c "Airbus : Perf Test .." 

indices=2
documents=2
clients=2
seconds=30
shards=4
replicas=1
bulk_size=500
max_fields_per_doc=50
max_size_per_field=500
stats_frequency=10

host=`grep server_name /home/ansible/Final/ELKStack/AirBus/inventory/group_vars/prod/vars.yml`
host=`echo $host | awk -F': ' '{print $NF}'`

password=`grep elastic_password /home/ansible/Final/ELKStack/AirBus/inventory/group_vars/prod/vars.yml`
password=`echo $password | awk -F': ' '{print $NF}'`
password=`echo $password | sed 's/"//g'`
username="elastic"

port=`grep ELASTICSEARCH_HOSTS /home/ansible/Final/ELKStack/AirBus/roles/kibana/tasks/main.yml`
port=`echo $port | awk -F'}:' '{print $NF}'`
port=`echo $port | sed 's/"//g'`




python -W ignore::DeprecationWarning es-perf-test.py  --es_address $host \
	--es_port $port \
        --indices $indices --documents $documents \
        --clients $clients --seconds $seconds \
        --number-of-shards $shards \
        --number-of-replicas $replicas \
        --bulk-size $bulk_size \
        --max-fields-per-document $max_fields_per_doc \
        --max-size-per-field $max_size_per_field \
        --stats-frequency $stats_frequency \
        --username $username \
        --password $password

