testing
testAccessAllEdgesViaRootGraph
	graph add: #A -> #B.
	graph subgraphDo: [ graph add: #B -> #C ].
	graph add: 123 -> 456.
	self assert: (graph edgeNamed: #A -> #B) notNil.
	self assert: (graph edgeNamed: #B -> #C) notNil.
	self assert: (graph edgeNamed: '123' -> '456') notNil