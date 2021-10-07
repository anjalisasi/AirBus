#!/usr/bin/env python

#AirBus Task 
#Pyuthon script to stress test ES 


import signal
import sys

# Using argparse to parse cli arguments
import argparse

# Import threading essentials
from threading import Lock, Thread, Condition, Event

# For randomizing
import string
from random import randint, choice

# To get the time
import time

# For misc
import sys

# For json operations
import json

# Try and import elasticsearch
try:
    from elasticsearch import Elasticsearch
    from elasticsearch.connection import create_ssl_context

except:
    print("Could not import elasticsearch..")
    print("Try: pip install elasticsearch")
    sys.exit(1)


import urllib3
urllib3.disable_warnings()

# Set a parser object
parser = argparse.ArgumentParser()

# Adds all params
parser.add_argument("--es_address", nargs='+', help="The address of your cluster (no protocol or port)", required=True)
parser.add_argument("--username", dest="auth_username", default="", help="HTTP authentication Username")
parser.add_argument("--password", dest="auth_password", default="", help="HTTP authentication Password")

# Parse the arguments
args = parser.parse_args()

# Set variables from argparse output (for readability)
AUTH_USERNAME = args.auth_username
AUTH_PASSWORD = args.auth_password


es = None  # Will hold the elasticsearch session


def main():
    auth = None 



    for esaddress in args.es_address:
        print("")
        print("Starting initialization of {0}".format(esaddress))
        try:
            # Initiate the elasticsearch session
            # We increase the timeout here from the default value (10 seconds)
            # to ensure we wait for requests to finish even if the cluster is overwhelmed
            # and it takes a bit longer to process one bulk.

         
            if AUTH_USERNAME and AUTH_PASSWORD:
                auth = (AUTH_USERNAME, AUTH_PASSWORD)

            es = Elasticsearch(
                esaddress,
                http_auth=auth,
                port=2222,
                scheme="http",
                timeout=60)

            print("check cluster Health ..")
            print(es.cluster.health())

        except Exception as e:
            print("Could not connect to elasticsearch!")
            print(e)
            sys.exit(1)


try:
    main()

except Exception as e:
    print("Got unexpected exception. probably a bug, please report it.")
    print("")
    print(e.message)
    print("")

    sys.exit(1)

