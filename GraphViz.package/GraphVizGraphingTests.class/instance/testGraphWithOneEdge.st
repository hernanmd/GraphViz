testing
testGraphWithOneEdge
	graph add: #A -> #B.
	self assert: (graph dot includesSubstring: '	A -- B;')