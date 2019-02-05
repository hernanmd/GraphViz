testing
testGraphWithTwoEdgesFromSameNode
	graph add: #A -> #B.
	graph add: #A -> #C.
	self assert: (graph dot includesSubstring: 'A -- B').
	self assert: (graph dot includesSubstring: 'A -- C')