testing
testAnonymousSubGraph
	graph subgraphDo: [ graph add: #A ].
	self assert: (graph dot lineNumber: 2) equals: '	{'.
	self assert: (graph dot lineNumber: 3) equals: '		A;'.
	self assert: (graph dot lineNumber: 4) equals: '	}'.
	self assert: (graph dot lineNumber: 5) equals: '}'