testing
testInheritedStyleCascadesThroughSubgraphs
	graph
		add: #node
		with:
			{(#color -> #blue).
			(#shape -> #ellipse)}.
	graph
		subgraphDo: [ graph add: #node with: #shape -> #box.
			graph add: #A ].
	graph add: #B.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph nodeNamed: #A) shape equals: #box.
	self assert: (graph nodeNamed: #B) color equals: #blue.
	self assert: (graph nodeNamed: #B) shape equals: #ellipse