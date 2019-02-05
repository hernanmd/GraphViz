testing
testWaitForNewerFile
	| generator testFile |
	generator := Win32GraphVizGenerator new.
	testFile := (tempDir / 'testFile') fullName.
	(FileStream forceNewFileNamed: testFile) close.
	self
		should: [ generator
				do: nil
				blockUntilFileUpdated: testFile
				waitingNoMoreThan: 1 second ]
		raise: Error.
	generator
		do: [ (FileStream forceNewFileNamed: testFile)
				nextPut: $.;
				close ]
		blockUntilFileUpdated: testFile
		waitingNoMoreThan: 1 second