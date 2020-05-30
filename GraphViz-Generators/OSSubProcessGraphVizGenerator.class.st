Class {
	#name : #OSSubProcessGraphVizGenerator,
	#superclass : #GraphVizGenerator,
	#category : #'GraphViz-Generators'
}

{ #category : #private }
OSSubProcessGraphVizGenerator >> buildCommandFor: aString [ 

	^ String streamContents: [ : stream |
			stream
				nextPutAll: self preferredProgram;
				space;
				nextPutAll: (self commandLineForFormat: aString) ]
]

{ #category : #private }
OSSubProcessGraphVizGenerator >> buildType: aString [ 

	^ String streamContents: [ : stream |
			stream
				nextPutAll: '-T';
				nextPutAll: aString ]
]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> commandLineForFormat: outputFormat [

	| file |
	file := self outputCommandLineFileNameFor: outputFormat.
	^ String streamContents: [ : stream |
		stream
			nextPutAll: self outputPathForCommandLine;
			nextPutAll: self dotFileName;
			nextPutAll: ' -T';
			nextPutAll: outputFormat;
			nextPutAll: ' -o ';
			nextPutAll: file ]
]

{ #category : #converting }
OSSubProcessGraphVizGenerator >> createMorph [
	"builds and returns a morph"

	^ (PNGReadWriter formFromStream: (self generateType: #png)) asMorph
]

{ #category : #converting }
OSSubProcessGraphVizGenerator >> createXMLDocument [
	"builds and returns an XMLDocument"
	"Warning: Some versions of the dot2gxl program do not correctly flush 
	output to a pipe or file. This method will fail in that case, with the XML 
	data appearing to have been truncated. If this happens, install a new
	version of the GraphViz package on your system."

	| dot2gxlProcess xml parser |
	
	self halt.
	dot2gxlProcess := self externalCommand: 'dot2gxl'.
	[xml := dot2gxlProcess
		nextPutAll: (self generateType: #dot);
		close;
		output]
			on: Error
			do: [self notify: dot2gxlProcess errorPipelineContents.
				^ xml ifNil: ['']].
	dot2gxlProcess succeeded ifFalse:
		[self notify: dot2gxlProcess errorPipelineContents].
	parser := Smalltalk at: #XMLDOMParser ifAbsent: [].
	^ parser
		ifNil: [xml]
		ifNotNil: [parser parseDocumentFrom: xml readStream]
]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> dotSourceWithLineFeedTerminators [
	"The external programs expect <lf> line terminators on Unix systems"

	^ self graph dot copyReplaceAll: String cr with: String lf
]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> evaluateUsing: externalProgram forType: outputFormat [
	" Run external program (i.e. dot, neato, fdp, twopi) and produce the requested output type.
	See the documentation for dot for a list of supported output types. No external files are produced. Answer the result output String ."

	| process actualStdout actualStderr exitedSemaphore |
	
	exitedSemaphore := Semaphore new.
	process := OSSUnixSubprocess new
		command: externalProgram;
		arguments: { self buildType: outputFormat };
		redirectStdout;
		redirectStderr;
		redirectStdin;
		yourself.
	[ process
		runAndWaitPollingEvery: (Delay forMilliseconds: 50)
		retrievingStreams: true
		onExitDo: [ :p :stdout :stderr | 
			actualStdout := stdout asByteArray readStream.
			actualStderr := stderr.
			exitedSemaphore signal ] ] forkAt: Processor activeProcess priority + 1.
	process stdinStream 
		nextPutAll: self dotSourceWithLineFeedTerminators;
		close.
	process waitForExit.
	process closeAndCleanStreams.
	exitedSemaphore wait.
	^ actualStdout 
]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> externalCommand: commandString [
	" Evaluate commandString using the receiver's context "

	self halt.
	^ OSSUnixSubprocess resultOfCommand: commandString
]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> generateType: outputTypeString [
	" Run dot and produce the requested output type. See the documentation for dot for a list of supported output types. No external files are produced."

	^ self
		evaluateUsing: self preferredProgram 
		forType: outputTypeString.


]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> make: outputFormat [
	"makes the requested output format on disk and returns full filename to output file 
	e.g. write a SVG output file and returns full path to the output file"

	| fileName |
	
	fileName := self outputFileNameFor: outputFormat.
	fileName asFileReference writeStreamDo: [ : stream |
		stream nextPutAll: (self generateType: outputFormat) ].
	^ fileName

]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> makeNoWait: outputFormat [

	self writeDotFile.
	self outputFileNameFor: outputFormat.
	self externalCommand: (self buildCommandFor: outputFormat)
]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> outputCommandLineFileNameFor: extension [

	^ String streamContents: [ : stream | 
			stream
				nextPutAll: self outputPathForCommandLine;
				nextPutAll: self baseFileName;
				nextPut: $.;
				nextPutAll: extension ]

]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> outputPathForCommandLine [

	| path |
	path := self outputPath copyReplaceAll: ':' with: '/'.
	path := path copyReplaceAll: ' ' with: '\ '.
	(path endsWith: '/') ifFalse: [ path := path , '/' ].
	^ path

]

{ #category : #generating }
OSSubProcessGraphVizGenerator >> writeDotFileNamed: aString [

	| fileName |
	fileName := aString.
	(aString endsWith: self dotExtension) ifFalse: [ fileName := fileName, self dotExtension ].
	(self outputFileDirectory asFileReference / fileName) 
		writeStreamDo: [ : f | f nextPutAll: self graph dot ]
]
