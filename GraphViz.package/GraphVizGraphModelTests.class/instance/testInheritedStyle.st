testing
testInheritedStyle
	graph add: #node with: #color -> #blue.
	graph add: #A.
	graph add: #B.
	graph add: #C with: #color -> #yellow.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph nodeNamed: #B) color equals: #blue.
	self assert: (graph nodeNamed: #C) color equals: #yellow