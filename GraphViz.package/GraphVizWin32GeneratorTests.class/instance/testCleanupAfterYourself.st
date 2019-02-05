testing
testCleanupAfterYourself
	self assert: tempDir entries isEmpty.
	graph add: #A.
	graph asMorph.
	graph asXml.
	self assert: tempDir entries isEmpty