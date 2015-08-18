import os
import datetime

def current_time():
    return datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def post_metric(metric_name, metric_value):
    try:
        command = "aws cloudwatch put-metric-data --namespace \"Service Layer Metrics\" --metric-name \"%s\" --value %s --region us-east-1" % (metric_name, metric_value)
        rCode = os.system(command)
        if rCode != 0: raise Exception("asw cli failed with code %s" % rCode)
    except Exception, e:
    	print str(e)
        return -1
