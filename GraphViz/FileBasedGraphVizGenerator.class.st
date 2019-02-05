Class {
	#name : #FileBasedGraphVizGenerator,
	#superclass : #GraphVizGenerator,
	#instVars : [
		'durationToWaitForGenerating',
		'deleteIntermediateFiles'
	],
	#category : #'GraphViz-Generators'
}

{ #category : #accessing }
FileBasedGraphVizGenerator >> beClean [

	deleteIntermediateFiles  := true
]

{ #category : #accessing }
FileBasedGraphVizGenerator >> beMessy [

	deleteIntermediateFiles  := false
]

{ #category : #private }
FileBasedGraphVizGenerator >> checkExternalProcessValue: returnValue modificationTime: originalModTime file: file latestModificationTime: latestModTime [
	| testfile |
	testfile := FileStream fileNamed: file.	"if file is openable for writing then probably the external process is done"
	^ testfile
		ifNotNil: [ 
			testfile close.
			originalModTime
				ifNil: [ ^ returnValue ]
				ifNotNil: [ 
					latestModTime > originalModTime
						ifTrue: [ ^ returnValue ] ]	"file did not exist before and now exists" ]
]

{ #category : #private }
FileBasedGraphVizGenerator >> cleanUpIntermediateFilesAsAppropriate [
	" needsWork "

	| entries |
	deleteIntermediateFiles ifFalse: [^ self].
	
"	(self outputFileDirectory / self dotFileName) asFileReference ensureDeleted.
	
	entries := self outputFileDirectory matchingEntries: (self baseFileName, '.*').
	entries do: [:each | self outputFileDirectory deleteFileNamed: each name]"
]

{ #category : #generating }
FileBasedGraphVizGenerator >> commandLineForFormat: outputFormat [

	self subclassResponsibility
]

{ #category : #private }
FileBasedGraphVizGenerator >> do: aBlock blockUntilFileUpdated: file waitingNoMoreThan: duration [

	| originalModTime |
	originalModTime := self modificationTimeOf: file.
	^ self 
		doWithStopWatch: aBlock
		modificationTime: originalModTime 
		blockUntilFileUpdated: file 
		waitingNoMoreThan: duration

]

{ #category : #private }
FileBasedGraphVizGenerator >> doWithStopWatch: aBlock modificationTime: originalModTime blockUntilFileUpdated: file waitingNoMoreThan: duration [
	| stopwatch returnValue |
	returnValue := aBlock value.
	stopwatch := Stopwatch new.
	stopwatch activate.
	[ stopwatch duration < duration ]
		whileTrue: [ 
			(self modificationTimeOf: file)
				ifNotNilDo: [ :latestModTime | 
					"if file is openable for writing then probably the external process is done"
					"file did not exist before and now exists"
					^ self
						checkExternalProcessValue: returnValue
						modificationTime: originalModTime
						file: file
						latestModificationTime: latestModTime ].
			1000 milliSeconds asDelay wait ].
	self error: 'Timeout expired waiting for ' , file , ' to be updated!'
]

{ #category : #accessing }
FileBasedGraphVizGenerator >> durationToWaitForGenerating [

	^ durationToWaitForGenerating ifNil: [30 seconds]
]

{ #category : #accessing }
FileBasedGraphVizGenerator >> durationToWaitForGenerating: aDuration [

	durationToWaitForGenerating := aDuration
]

{ #category : #generating }
FileBasedGraphVizGenerator >> evaluateUsing: externalProgram forType: outputFormat [

	self
		runOSProcess: externalProgram 
		with: (self commandLineForFormat: outputFormat)
]

{ #category : #generating }
FileBasedGraphVizGenerator >> generateType: outputTypeString [
	"Run dot and produce a string with the requested output type. See the
	documentation for dot for a list of supported output types."

	| fs converterClass |
	self make: outputTypeString.
	fs := FileStream readOnlyFileNamed: (self outputFileNameFor: outputTypeString).
	
	[converterClass := Smalltalk
		at: #Latin1TextConverter
		ifAbsent: [nil].
	converterClass ifNotNil: [fs converter: converterClass new].
	^ fs contentsOfEntireFile] ensure:
		[fs close.
		self cleanUpIntermediateFilesAsAppropriate]
]

{ #category : #initialization }
FileBasedGraphVizGenerator >> initialize [

	super initialize.
	self beClean
]

{ #category : #generating }
FileBasedGraphVizGenerator >> make: outputFormat [

	^ self 
		do: [self makeNoWait: outputFormat]
		blockUntilFileUpdated: (self outputFileNameFor: outputFormat)
		waitingNoMoreThan: self durationToWaitForGenerating
]

{ #category : #generating }
FileBasedGraphVizGenerator >> makeNoWait: outputFormat [

	self writeDotFile.
	self evaluateUsing: self preferredProgram forType: outputFormat.
	
	^ self outputFileNameFor: outputFormat
]

{ #category : #accessing }
FileBasedGraphVizGenerator >> modificationTimeOf: aString [
	" #modificationTime answer false OR DateAndTime (???) "

	| answer |

	answer := aString asFileReference ifNotNilDo: [ : entry | 
		[ entry modificationTime ]
		on: FileDoesNotExist 
		do: [ : ex | nil ] ].
	(answer isKindOf: DateAndTime) ifTrue: [ ^ answer ].
	^ nil.

]

{ #category : #external }
FileBasedGraphVizGenerator >> runOSProcess: command with: arguments [ 

	self subclassResponsibility
]
