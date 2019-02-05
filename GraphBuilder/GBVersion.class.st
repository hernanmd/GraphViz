Class {
	#name : #GBVersion,
	#superclass : #Object,
	#instVars : [
		'version',
		'info',
		'uid',
		'ancestors',
		'dependencies'
	],
	#category : #'GraphBuilder-Monticello'
}

{ #category : #'instance creation' }
GBVersion class >> info: aVersionInfo [
	^self new
		setInfo: aVersionInfo;
		yourself.
]

{ #category : #'instance creation' }
GBVersion class >> repository: aRepository filename: aFilename [
	
	^ self version: (aRepository versionFromFileNamed: aFilename)
"	^ [ self version: (aRepository versionFromFileNamed: aFilename) ]
	on: MCRepositoryError, ZnHttpUnsuccessful
	do: [ : ex | self halt. ]"
]

{ #category : #'instance creation' }
GBVersion class >> version: aVersion [
	^self new
		setVersion: aVersion;
		yourself.
]

{ #category : #comparing }
GBVersion >> <= anObject [

	self package < anObject package
		ifTrue: [ ^true ].
	self package = anObject package
		ifTrue: [ ^self number asNumber > anObject number asNumber ].
	^false.
]

{ #category : #comparing }
GBVersion >> = anObject [
	^self class = anObject class
		and: [ self uid = anObject uid ].
]

{ #category : #accessing }
GBVersion >> ancestors [
	^ancestors
]

{ #category : #'accessing-dynamic' }
GBVersion >> author [
	^self info author.
]

{ #category : #'accessing-dynamic' }
GBVersion >> date [
	" Answer a <String> with receiver's commit date "
	
	^ self info date ddmmyyyy
]

{ #category : #'accessing-dynamic' }
GBVersion >> deep [
	^Array streamContents: [ :stream |
		self dependencies do: [ :each |
			stream nextPut: each.
			stream nextPutAll: each deep ] ].
]

{ #category : #accessing }
GBVersion >> dependencies [
	^dependencies
]

{ #category : #comparing }
GBVersion >> hash [
	^self uid hash.
]

{ #category : #accessing }
GBVersion >> info [
	^info
]

{ #category : #'accessing-dynamic' }
GBVersion >> label [
	" Private - Build node contents "
	
	^ String streamContents: [ : stream |
		stream 
			nextPutAll: self date;
			nextPut: $|;
			nextPutAll: self package; 
			nextPut: $|;
			nextPutAll: self author; 
			nextPut: $|;
			nextPutAll: self number asString ].
]

{ #category : #'accessing-dynamic' }
GBVersion >> number [
	| number |
	number := self info name copyAfterLast: $..
	^ (number notEmpty and: [ number isAllDigits ])
		ifTrue: [ number asNumber ]
		ifFalse: [ 0 ].
]

{ #category : #'accessing-dynamic' }
GBVersion >> package [
	^self info name copyUpToLast: $-
]

{ #category : #printing }
GBVersion >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' ['; nextPutAll: self info name; nextPutAll: ']'
]

{ #category : #initialization }
GBVersion >> setAncestors: aSet [
	ancestors := aSet
]

{ #category : #initialization }
GBVersion >> setDependencies: aSet [
	dependencies := aSet
]

{ #category : #initialization }
GBVersion >> setInfo: aVersionInfo [
	info := aVersionInfo.
	uid := aVersionInfo id asString36.
]

{ #category : #initialization }
GBVersion >> setVersion: aVersion [
	version := aVersion.
	self setInfo: aVersion info.
]

{ #category : #accessing }
GBVersion >> uid [
	^uid
]

{ #category : #accessing }
GBVersion >> version [
	^version
]
