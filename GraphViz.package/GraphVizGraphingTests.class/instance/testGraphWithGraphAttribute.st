testing
testGraphWithGraphAttribute
	graph add: #graph with: #start -> #rand.
	self assert: (graph dot includesSubstring: 'graph [start=rand];')