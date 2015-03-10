testing
testGraphWithEdgeAttribute

	graph add: #edge with: #dir -> #both.
	self should: [graph dot includesSubstring: 'edge [dir=both];']