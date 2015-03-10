testing
testWaitForNewFile

	| generator testFile  |
	generator := Win32GraphVizGenerator new.
	testFile := (tempDir / 'testFile') fullName.
	
	self should:
		[generator
			do: nil
			blockUntilFileUpdated: testFile
			waitingNoMoreThan: 1 second] raise: Error.
	
	self shouldnt:
		[generator
			do: [(FileStream forceNewFileNamed: testFile) nextPut: $.; close]
			blockUntilFileUpdated: testFile
			waitingNoMoreThan: 1 second] raise: Error