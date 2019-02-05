testing
testModelRecordsOnlyUniqueNodes
	| newNode |
	graph add: #A.
	self assert: graph nodes size equals: 1.
	self assert: graph nodes first id equals: #A.
	newNode := graph add: #A.
	self assert: graph nodes size = 1.
	self assert: newNode equals: (graph nodeNamed: #A)