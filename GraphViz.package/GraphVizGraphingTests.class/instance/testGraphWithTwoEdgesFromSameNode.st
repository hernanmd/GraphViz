testing
testGraphWithTwoEdgesFromSameNode

	graph add: #A -> #B.
	graph add: #A -> #C.
	
	self should: [graph dot includesSubstring: 'A -- B'].
	self should: [graph dot includesSubstring: 'A -- C'].