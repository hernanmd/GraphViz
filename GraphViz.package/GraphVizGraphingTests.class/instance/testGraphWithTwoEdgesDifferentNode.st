testing
testGraphWithTwoEdgesDifferentNode

	graph add: #A -> #B.
	graph add: #B -> #C.
	
	self should: [graph dot includesSubstring: 'A -- B'].
	self should: [graph dot includesSubstring: 'B -- C'].