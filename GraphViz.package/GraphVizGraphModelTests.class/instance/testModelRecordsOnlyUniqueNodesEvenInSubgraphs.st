testing
testModelRecordsOnlyUniqueNodesEvenInSubgraphs
	graph add: #A.
	graph subgraphDo: [ graph add: #A ].
	self assert: graph nodes size equals: 1.
	self assert: graph subgraphs first nodes size equals: 1.
	self assert: graph nodes first = graph subgraphs first nodes first