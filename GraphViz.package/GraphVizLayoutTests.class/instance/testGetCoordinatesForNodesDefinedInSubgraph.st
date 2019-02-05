testing
testGetCoordinatesForNodesDefinedInSubgraph
	| node |
	graph subgraphDo: [ node := graph add: #A ].
	graph doLayout.
	self assert: node x > 0.
	self assert: node y > 0.
	self assert: node height > 0.
	self assert: node width > 0