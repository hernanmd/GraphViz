testing
testGraphWithGraphAttribute

	graph add: #graph with: #start -> #rand.
	self should: [graph dot includesSubstring: 'graph [start=rand];']