input { 
	file { 
		path => "path_to_service_Logs/*.log"
		start_position => "beginning"			
		codec => plain { charset => "UTF-16" }
		sincedb_path => "path_to_store_sincedb/.sincedb-service-logs"
		start_position => "beginning"
		sincedb_write_interval => 15
	}
}

filter {
	csv 
	{
		separator => ","
		columns => [ "Date","LogLevel","ThreadId","LoggerName","RequestId","ClientTime","ClientHostName","ClientPID","ClientThread","Message"]
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
