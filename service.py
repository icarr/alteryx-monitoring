#!/usr/bin/python

import urllib2
from globals import *

SL_URLS = {   
   "Master":
       {
           "url": "http://x.x.x.x/AlteryxService/Status",
           "expected": "<ServerName>AlteryxService</ServerName>"
       },
   "Worker":
    {
        "url": "http://x.x.x.x/AlteryxService/Status",
        "expected": "<ServerName>AlteryxService</ServerName>"
    }
}


def __main():
    for k, v in SL_URLS.iteritems():
        status = 1
        try:
            f = urllib2.urlopen(v["url"])
            text = f.read()
            if not v["expected"] in text:
                status = 0
        except Exception, e:
            print str(e)
            status = 0

        post_metric(k, status)


__main()

