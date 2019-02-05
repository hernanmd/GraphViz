testing
testGraphWithNodeAttribute
	graph add: #node with: #shape -> #box.
	self assert: (graph dot includesSubstring: 'node [shape=box];')