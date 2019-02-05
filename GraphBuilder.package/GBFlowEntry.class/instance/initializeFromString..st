initialize-release
initializeFromString: aString
	(EntryRegex search: aString)
		ifFalse: [ self error: 'Invalid Log Entry: ' , aString ].
		
	" parse log entry "
	timestamp := TimeStamp
		date: (Date fromString: (EntryRegex subexpression: 2))
		time: (Time fromString: (EntryRegex subexpression: 3)).
	method := EntryRegex subexpression: 4.
	components := EntryRegex subexpression: 5.
	referee := EntryRegex subexpression: 6.
	type := EntryRegex subexpression: 7.
	fields := EntryRegex subexpression: 8.
	
	" find continuations "
	ContinuationRegex
		matchesIn: referee
		do: [ :value |  previousCC := ContinuationRegex subexpression: 2 ].
	ContinuationRegex
		matchesIn: fields
		do: [ :value |  currentCC := ContinuationRegex subexpression: 2 ].