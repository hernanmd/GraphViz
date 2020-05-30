Class {
	#name : #GraphVizWin32GeneratorTests,
	#superclass : #GraphVizBaseTests,
	#category : #GraphVizTests
}

{ #category : #'as yet unclassified' }
GraphVizWin32GeneratorTests class >> isAbstract [

	^ Smalltalk os platformName  = 'Win 32'
]

{ #category : #testing }
GraphVizWin32GeneratorTests >> testCleanupAfterYourself [
	self assert: tempDir entries isEmpty.
	graph add: #A.
	graph asMorph.
	graph asXml.
	self assert: tempDir entries isEmpty
]

{ #category : #testing }
GraphVizWin32GeneratorTests >> testWaitForNewFile [
	| generator testFile |
	generator := Win32GraphVizGenerator new.
	testFile := (tempDir / 'testFile') fullName.
	self
		should: [ generator
				do: nil
				blockUntilFileUpdated: testFile
				waitingNoMoreThan: 1 second ]
		raise: Error.
	generator
		do: [ 
			testFile asFileReference 
				ensureDelete;
				writeStreamDo: [ : stream | stream nextPut: $. ] ]
		blockUntilFileUpdated: testFile
		waitingNoMoreThan: 1 second
]

{ #category : #testing }
GraphVizWin32GeneratorTests >> testWaitForNewerFile [
	| generator testFile |
	generator := Win32GraphVizGenerator new.
	testFile := (tempDir / 'testFile') fullName.
	testFile asFileReference ensureDelete.
	self
		should: [ generator
				do: nil
				blockUntilFileUpdated: testFile
				waitingNoMoreThan: 1 second ]
		raise: Error.
	generator
		do: [ 
			testFile asFileReference 
				ensureDelete;
				writeStreamDo: [ : stream | stream nextPut: $. ] ]
		blockUntilFileUpdated: testFile
		waitingNoMoreThan: 1 second
]
