testing
testSubgraphInSubgraphs
	graph
		subgraph: #foo
		do: [ graph subgraph: #bar do: [ graph add: #A ] ].
	self assert: graph nodes isEmpty.
	self assert: graph subgraphs size equals: 1.
	self assert: graph subgraphs first id equals: #foo.
	self assert: graph subgraphs first nodes isEmpty.
	self assert: graph subgraphs first subgraphs size equals: 1.
	self assert: graph subgraphs first subgraphs first id equals: #bar.
	self
		assert: graph subgraphs first subgraphs first nodes size
		equals: 1.
	self
		assert: graph subgraphs first subgraphs first nodes first id
		equals: #A