testing
testGetCoordinatesForNodes
	| node |
	graph add: #A -> #B.
	graph doLayout.
	node := graph nodeNamed: #A.
	self assert: node x > 0.
	self assert: node y > 0.
	self assert: node height > 0.
	self assert: node width > 0