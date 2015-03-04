# Alteryx Service Monitoring Utilities

## Log parsing tools

	Included are two examples of logatash filters for parsing gallery and service logs.  The included examples send the parsed output to elasticsearch.

## Queue monitoring
	
	An example of how you can monitor how many jobs are in the Alteryx Service queue.  The included example also shows how these metrics can be sent to AWS CloudWatch for alerting.

## Service monitoring

	An example of a health check monitor for Alteryx Service node.  This example allow you to specify which nodes to monitor and what the expected result should contain.  Sqllite is used as a simple way to persist state between polling intervals to enable alerting of an UP or DOWN status.
