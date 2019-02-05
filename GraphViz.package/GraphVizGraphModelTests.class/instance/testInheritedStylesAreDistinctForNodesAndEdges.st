testing
testInheritedStylesAreDistinctForNodesAndEdges
	graph add: #node with: #color -> #blue.
	graph add: #edge with: #color -> #yellow.
	graph add: #A.
	graph add: #A -> #B.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph edgeNamed: #A -> #B) color = #yellow