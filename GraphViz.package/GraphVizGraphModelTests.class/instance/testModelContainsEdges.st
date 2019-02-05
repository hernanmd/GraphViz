testing
testModelContainsEdges
	graph add: #A -> #B.
	self assert: graph edges size equals: 1.
	self assert: graph edges first id equals: #A -> #B.
	self assert: graph nodes size equals: 2.
	self assert: graph nodes first id equals: #A.
	self assert: graph nodes second id equals: #B