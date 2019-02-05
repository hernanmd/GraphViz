class initialization
initialize
	EntryRegex := '\d+\.\d+\.\d+\.\d+ \S+ \S+ \[(\d\d/\w\w\w/\d\d\d\d)\:(\d\d\:\d\d\:\d\d) \+\d+\] "(POST|GET) (\S+) [^"]+" \d+ \d+ "([^"]+)" "[^"]+" (\w+) \d+ (.*);' asRegex.
	ContinuationRegex := '_k=(\w+)' asRegex.