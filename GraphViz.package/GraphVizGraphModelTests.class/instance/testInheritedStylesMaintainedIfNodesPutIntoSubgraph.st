testing
testInheritedStylesMaintainedIfNodesPutIntoSubgraph
	graph := GraphViz new
		add: #node with: #fontsize -> 16;
		add: #A;
		add: #node with: #fontsize -> 10;
		yourself.
	graph subgraphDo: [ graph add: #A ].
	self assert: (graph nodeNamed: #A) fontSize equals: 16