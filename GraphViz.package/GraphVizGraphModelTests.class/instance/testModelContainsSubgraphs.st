testing
testModelContainsSubgraphs
	graph subgraph: #foo do: [ graph add: #A ].
	self assert: graph nodes isEmpty.
	self assert: graph subgraphs size equals: 1.
	self assert: graph subgraphs first id equals: #foo.
	self assert: graph subgraphs first nodes size equals: 1.
	self assert: graph subgraphs first nodes first id equals: #A