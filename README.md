# Alteryx Service Monitoring Utilities

## Log parsing tools

Included are two examples of logatash filters for parsing gallery and service logs.  The included examples send the parsed output to elasticsearch.

## Queue monitoring
	
A python example of how you can monitor the number of jobs in the Alteryx Service queue.  The included example also shows how these metrics can be sent to AWS CloudWatch for alerting.

## Service monitoring

A python example of a health check monitor for Alteryx Service nodes.  This example allows you to specify which nodes to monitor and what the expected result should contain.  Sqlite is used as a simple way to persist state between polling intervals which can be used to enable alerting of an UP or DOWN status.