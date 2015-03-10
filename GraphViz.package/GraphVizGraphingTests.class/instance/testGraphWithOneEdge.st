testing
testGraphWithOneEdge

	graph add: #A -> #B.
	
	self should: [graph dot includesSubstring: '	A -- B;'].