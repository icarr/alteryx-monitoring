#!/usr/bin/python

import urllib2
from globals import *

# SQL Settings
SQL_DB_NAME = 'monitoring.sqlite'
SQL_TABLE_NAME = "nodes"

#URL Settings
SL_URLS = {
    "Master":
        {
            "url": "http://master/AlteryxService/Status",
            "expected": "<ServerName>AlteryxService</ServerName>"
        },
    "Worker":
        {
            "url": "http://worker/AlteryxService/Status",
            "expected": "<ServerName>AlteryxService</ServerName>"
        }
}


def __main():
    for k, v in SL_URLS.iteritems():
        status = "UP"
        try:
            f = urllib2.urlopen(v["url"])
            text = f.read()
            if not v["expected"] in text:
                status = "DOWN"
        except:
            status = "DOWN"

        updateStatus(k, v["url"], status)


__main()

