testing
testGraphWithNodeAttribute

	graph add: #node with: #shape -> #box.
	self should: [graph dot includesSubstring: 'node [shape=box];']