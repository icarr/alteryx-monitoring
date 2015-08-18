#!/usr/bin/python

import os
from globals import *
from pymongo import MongoClient

DB_SERVER = ''
DB_PORT   = 27017
DB_USER   = ''
DB_PWD    = ''


def _main():
    count = get_count()
    post_metric("Queued Jobs", count)


def get_count():
    count = 0
    try:
        client = MongoClient(DB_SERVER, DB_PORT)
        client.AlteryxService.authenticate(DB_USER, DB_PWD)
        db = client.AlteryxService
        queue_collection = db.AS_Queue
        count = queue_collection.find({"Status": "Queued"}).count()
        client.close()
    except Exception, e:
        print str(e)
        count = 999
    finally:
        return count


_main()




