input { 
	file 
	{ 
    	path => "path_to_gallery_Logs/*.csv"
		codec => multiline 
		{
		  pattern => "^%{TIMESTAMP_ISO8601},"
		  negate => true
		  what => previous
		}
		sincedb_path => "path_to_store_sincedb/.sincedb-gallery-logs"
	}
}

filter {
	
	grok 
	{
		#full exceptions
		match => [ "message", "%{TIMESTAMP_ISO8601:Date},%{LOGLEVEL:LogLevel},%{NUMBER:ThreadId},%{JAVACLASS:LoggerName},%{WORD:RequestId},%{WORD:UserId},%{IP:ClientIP},%{HOST:Server},%{NUMBER:RequestSize},%{QUOTEDSTRING:UserAgent},%{WORD:RequestMethod},%{URIRESTPATH:RequestTarget},%{NUMBER:ResponseCode},%{NUMBER:ResponseTime},%{DATA:Message},%{QUOTEDSTRING:Exception}" ]
		add_tag => "_fullexception"
	}

	grok 
	{
		#unquoted user agent
		match => [ "message", "%{TIMESTAMP_ISO8601:Date},%{LOGLEVEL:LogLevel},%{NUMBER:ThreadId},%{JAVACLASS:LoggerName},%{WORD:RequestId},%{WORD:UserId},%{IP:ClientIP},%{HOST:Server},%{NUMBER:RequestSize},%{DATA:UserAgent},%{WORD:RequestMethod},%{URIRESTPATH:RequestTarget},%{NUMBER:ResponseCode},%{NUMBER:ResponseTime},%{DATA:Message},%{QUOTEDSTRING:Exception}" ]
		add_tag => "_unquoteduseragent"
	}

	grok 
	{
		#exceptions missing UserAgent
		match => [ "message", "%{TIMESTAMP_ISO8601:Date},%{LOGLEVEL:LogLevel},%{NUMBER:ThreadId},%{JAVACLASS:LoggerName},%{WORD:RequestId},%{WORD:UserId},%{IP:ClientIP},%{HOST:Server},%{NUMBER:RequestSize},,%{WORD:RequestMethod},%{URIRESTPATH:RequestTarget},%{NUMBER:ResponseCode},%{NUMBER:ResponseTime},%{DATA:Message},%{QUOTEDSTRING:Exception}" ]
		add_tag => "_missinguseragent"
	}

	grok 
	{
		#un-quoted user agent, no response code
		match => [ "message", "%{TIMESTAMP_ISO8601:Date},%{LOGLEVEL:LogLevel},%{NUMBER:ThreadId},%{JAVACLASS:LoggerName},%{WORD:RequestId},%{WORD:UserId},%{IP:ClientIP},%{HOST:Server},%{NUMBER:RequestSize},%{DATA:UserAgent},%{WORD:RequestMethod},%{URIRESTPATH:RequestTarget},,%{NUMBER:ResponseTime},%{DATA:Message},%{QUOTEDSTRING:Exception}" ]
		add_tag => "_unquoteduseragent_noresponsecode"
	}	

	grok 
	{
		#exceptions missing response code
		match => [ "message", "%{TIMESTAMP_ISO8601:Date},%{LOGLEVEL:LogLevel},%{NUMBER:ThreadId},%{JAVACLASS:LoggerName},%{WORD:RequestId},%{WORD:UserId},%{IP:ClientIP},%{HOST:Server},%{NUMBER:RequestSize},%{QUOTEDSTRING:UserAgent},%{WORD:RequestMethod},%{URIRESTPATH:RequestTarget},,%{NUMBER:ResponseTime},%{DATA:Message},%{QUOTEDSTRING:Exception}" ]
		add_tag => "_missingresponsecode"
	}	

	grok 
	{
		#server exceptions
		match => [ "message", "%{TIMESTAMP_ISO8601:Date},%{LOGLEVEL:LogLevel},%{NUMBER:ThreadId},%{JAVACLASS:LoggerName},,,,,,,,,,,%{DATA:Message},%{QUOTEDSTRING:Exception}" ]
		add_tag => "_serverexception"
	}	

	csv 
	{
		separator => ","
		columns => [ "Date","LogLevel","ThreadId","LoggerName","RequestId","UserId","ClientIP","Server","RequestSize","UserAgent","RequestMethod","RequestTarget","ResponseCode","ResponseTime","Message","Exception"]
		add_tag => "_csvparsed"
	}

}

output {
	stdout { codec => rubydebug }

  	elasticsearch { 
		host => "x.x.x.x"
		protocol => "http"
		port => "9200"
		cluster => "elasticsearch"
	}
}
