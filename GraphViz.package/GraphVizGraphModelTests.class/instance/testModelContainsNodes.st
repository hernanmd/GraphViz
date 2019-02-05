testing
testModelContainsNodes
	graph add: #A.
	self assert: graph nodes size equals: 1.
	self assert: graph nodes first id equals: #A.
	graph add: #B.
	self assert: graph nodes size = 2.
	self assert: graph nodes second id equals: #B