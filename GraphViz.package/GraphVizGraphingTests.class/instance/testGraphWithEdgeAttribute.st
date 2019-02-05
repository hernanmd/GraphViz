testing
testGraphWithEdgeAttribute
	graph add: #edge with: #dir -> #both.
	self assert: (graph dot includesSubstring: 'edge [dir=both];')