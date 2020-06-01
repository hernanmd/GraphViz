Class {
	#name : #OSSubprocessGVGenerator,
	#superclass : #GraphVizGenerator,
	#category : #'GraphViz-Generators'
}

{ #category : #private }
OSSubprocessGVGenerator >> buildType: aString [ 

	^ String streamContents: [ : stream |
			stream
				nextPutAll: '-T';
				nextPutAll: aString ]
]

{ #category : #generating }
OSSubprocessGVGenerator >> commandLineForFormat: outputFormat [

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
OSSubprocessGVGenerator >> createMorph [
	"builds and returns a morph"

	^ (PNGReadWriter formFromStream: (self generateType: #png) asByteArray readStream) asMorph
]

{ #category : #creation }
OSSubprocessGVGenerator >> createXMLDocument [
	"builds and returns an XMLDocument"
	"Warning: Some versions of the dot2gxl program do not correctly flush 
	output to a pipe or file. This method will fail in that case, with the XML 
	data appearing to have been truncated. If this happens, install a new
	version of the GraphViz package on your system."

	^ XMLDOMParser parse: (self evaluateUsing: 'dot2gxl' forGxl: #dot) readStream
]

{ #category : #generating }
OSSubprocessGVGenerator >> dotSourceWithLineFeedTerminators [
	"The external programs expect <lf> line terminators on Unix systems"

	^ self graph dot copyReplaceAll: String cr with: String lf
]

{ #category : #generating }
OSSubprocessGVGenerator >> evaluateUsing: externalProgram arguments: args [
	" Run external program (i.e. dot, neato, fdp, twopi) and produce the requested output type.
	See the documentation for dot for a list of supported output types. No external files are produced. Answer the result output String ."

	| process actualStdout actualStderr exitedSemaphore |
	
	exitedSemaphore := Semaphore new.
	process := self subprocessClass new
		command: externalProgram;
		arguments: args;
		redirectStdout;
		redirectStderr;
		redirectStdin;
		yourself.
	[ process
		runAndWaitPollingEvery: (Delay forMilliseconds: 50)
		retrievingStreams: true
		onExitDo: [ :p :stdout :stderr | 
			actualStdout := stdout.
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
OSSubprocessGVGenerator >> evaluateUsing: externalProgram forGxl: outputFormat [
	" Run external program (i.e. dot, neato, fdp, twopi) and produce the requested output type.
	See the documentation for dot for a list of supported output types. No external files are produced. Answer the result output String ."

	^ self evaluateUsing: externalProgram arguments: { '-g' }.
]

{ #category : #generating }
OSSubprocessGVGenerator >> evaluateUsing: externalProgram forType: outputFormat [
	" Run external program (i.e. dot, neato, fdp, twopi) and produce the requested output type.
	See the documentation for dot for a list of supported output types. No external files are produced. Answer the result output String ."

	^ self evaluateUsing: externalProgram arguments: { self buildType: outputFormat }
]

{ #category : #generating }
OSSubprocessGVGenerator >> generateType: outputTypeString [
	" Run dot and produce the requested output type. See the documentation for dot for a list of supported output types. No external files are produced."

	^ self
		evaluateUsing: self preferredProgram 
		forType: outputTypeString.


]

{ #category : #generating }
OSSubprocessGVGenerator >> make: outputFormat [
	"makes the requested output format on disk and returns full filename to output file 
	e.g. write a SVG output file and returns full path to the output file"

	| fileName |
	
	fileName := self outputFileNameFor: outputFormat.
	fileName asFileReference writeStreamDo: [ : stream |
		stream nextPutAll: (self generateType: outputFormat) ].
	^ fileName

]

{ #category : #generating }
OSSubprocessGVGenerator >> makeNoWait: outputFormat [

	self writeDotFile.
	self outputFileNameFor: outputFormat.
	self evaluateUsing: self preferredProgram forType: outputFormat.
]

{ #category : #generating }
OSSubprocessGVGenerator >> outputCommandLineFileNameFor: extension [

	^ String streamContents: [ : stream | 
			stream
				nextPutAll: self outputPathForCommandLine;
				nextPutAll: self baseFileName;
				nextPut: $.;
				nextPutAll: extension ]

]

{ #category : #generating }
OSSubprocessGVGenerator >> outputPathForCommandLine [

	| path |
	path := self outputPath copyReplaceAll: ':' with: '/'.
	path := path copyReplaceAll: ' ' with: '\ '.
	(path endsWith: '/') ifFalse: [ path := path , '/' ].
	^ path

]

{ #category : #generating }
OSSubprocessGVGenerator >> subprocessClass [

	^ GraphViz defaultGeneratorClass
]

{ #category : #generating }
OSSubprocessGVGenerator >> writeDotFileNamed: aString [

	| fileName |
	fileName := aString.
	(aString endsWith: self dotExtension) ifFalse: [ fileName := fileName, self dotExtension ].
	(self outputFileDirectory asFileReference / fileName) 
		writeStreamDo: [ : f | f nextPutAll: self graph dot ]
]
