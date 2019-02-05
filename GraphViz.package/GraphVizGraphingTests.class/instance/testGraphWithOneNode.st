testing
testGraphWithOneNode
	graph add: #A.
	self assert: (graph dot lineNumber: 2) = '	A;'