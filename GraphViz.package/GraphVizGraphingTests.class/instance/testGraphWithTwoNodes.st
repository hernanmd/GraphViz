testing
testGraphWithTwoNodes
	graph add: #A.
	graph add: #B.
	self assert: (graph dot lineNumber: 2) equals: '	A;'.
	self assert: (graph dot lineNumber: 3) equals: '	B;'