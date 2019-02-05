testing
testGraphWithTwoEdgesDifferentNode
	graph add: #A -> #B.
	graph add: #B -> #C.
	self assert: (graph dot includesSubstring: 'A -- B').
	self assert: (graph dot includesSubstring: 'B -- C')