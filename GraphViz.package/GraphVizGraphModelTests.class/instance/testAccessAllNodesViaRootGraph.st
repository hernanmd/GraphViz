testing
testAccessAllNodesViaRootGraph
	graph add: #A.
	graph subgraphDo: [ graph add: #B ].
	graph add: 123.
	self assert: (graph nodeNamed: #A) notNil.
	self assert: (graph nodeNamed: #B) notNil.
	self assert: (graph nodeNamed: #C) isNil.
	self assert: (graph nodeNamed: '123') notNil