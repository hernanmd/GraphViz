Class {
	#name : #GBFlowEntry,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'method',
		'components',
		'referee',
		'type',
		'fields',
		'previousCC',
		'currentCC'
	],
	#classVars : [
		'ContinuationRegex',
		'EntryRegex'
	],
	#pools : [
		'ChronologyConstants'
	],
	#category : #'GraphBuilder-Log'
}

{ #category : #'instance creation' }
GBFlowEntry class >> fromString: aString [
	^ self new
		initializeFromString: aString;
		yourself.
]

{ #category : #'class initialization' }
GBFlowEntry class >> initialize [
	EntryRegex := '\d+\.\d+\.\d+\.\d+ \S+ \S+ \[(\d\d/\w\w\w/\d\d\d\d)\:(\d\d\:\d\d\:\d\d) \+\d+\] "(POST|GET) (\S+) [^"]+" \d+ \d+ "([^"]+)" "[^"]+" (\w+) \d+ (.*);' asRegex.
	ContinuationRegex := '_k=(\w+)' asRegex.
]

{ #category : #accessing }
GBFlowEntry >> components [
	^ components
]

{ #category : #accessing }
GBFlowEntry >> currentCC [
	^ currentCC
]

{ #category : #'initialize-release' }
GBFlowEntry >> initializeFromString: aString [
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
]

{ #category : #accessing }
GBFlowEntry >> method [
	^ method
]

{ #category : #accessing }
GBFlowEntry >> previousCC [
	^ previousCC
]

{ #category : #accessing }
GBFlowEntry >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GBFlowEntry >> type [
	^ type
]

{ #category : #accessing }
GBFlowEntry >> uuid [
	^ timestamp julianDayNumber * NanosInSecond * SecondsInDay 
		+ timestamp asNanoSeconds 
		+ self identityHash.
]
