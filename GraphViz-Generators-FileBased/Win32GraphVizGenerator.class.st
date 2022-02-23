"
GraphViz wrapper using ProcessWrapper and OSProcess

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Win32GraphVizGenerator,
	#superclass : #FileBasedGraphVizGenerator,
	#category : #'GraphViz-Generators-FileBased'
}

{ #category : #external }
Win32GraphVizGenerator >> buildCommand: command with: arguments [

	^ String streamContents: [ : stream |
		stream
			nextPutAll: command;
			space;
			nextPutAll: arguments ]

]

{ #category : #accessing }
Win32GraphVizGenerator >> commandLineForFormat: outputFormat [

	| file |
	file := self outputFileNameFor: outputFormat.
	
	^ String streamContents:
		[:stream |
		stream
			nextPut: $";
			nextPutAll: self dotFileName;
			nextPutAll: '" -T';
			nextPutAll: outputFormat;
			nextPutAll: ' -o "';
			nextPutAll: file;
			nextPut: $"]
]

{ #category : #creation }
Win32GraphVizGenerator >> createMorph [

	^  [
		(PNGReadWriter formFromStream: (self generateType: #png)) first asMorph
		] 
		ensure: [self cleanUpIntermediateFilesAsAppropriate]
]

{ #category : #creation }
Win32GraphVizGenerator >> createXMLDocument [

	| file parser xml |
	file := self make: #dot.
	
	file := self 
		do: [self launchDot2Gxl: file]
		blockUntilFileUpdated: (self outputFileNameFor: #xml)
		waitingNoMoreThan: self durationToWaitForGenerating.

	parser := Smalltalk at: #XMLDOMParser ifAbsent: [nil].
	xml := FileStream readOnlyFileNamed: file.
	^ [parser
		ifNil: [xml contents]
		ifNotNil: [parser parseDocumentFrom: xml]] ensure: [xml close. self cleanUpIntermediateFilesAsAppropriate]
]

{ #category : #external }
Win32GraphVizGenerator >> launchDot2Gxl: inputFile [

	| xmlFile |
	xmlFile := self outputFileNameFor: #xml.
	self
		runOSProcess: 'dot2gxl' 
		with: ('-o "', xmlFile, '" "', inputFile, '"').
		
	^ xmlFile
]

{ #category : #creation }
Win32GraphVizGenerator >> openInBrowser [

	| file |
	file := self  make: #svg.
	file := self writeHtmlSvgFor: file.
	WinShell shellOpen: file
]

{ #category : #external }
Win32GraphVizGenerator >> runOSProcess: command with: arguments [
	" Private - GraphViz should be present in the PATH environment variable "
	
	^ ProcessWrapper new
		startWithShellCommand: (self buildCommand: command with: arguments);
		upToEnd	


]
