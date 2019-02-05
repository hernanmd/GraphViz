testing
testSubgraphsVsGraphs
	self assert: graph isGraph.
	self shouldnt: [ graph isSubgraph ].
	graph subgraph: #foo do: [  ].
	self assert: graph subgraphs first isGraph.
	self assert: graph subgraphs first isSubgraph.
	graph subgraphDo: [ graph rank: #same ].
	self assert: graph attributes isEmpty.
	self assert: graph subgraphs last attributes size = 1