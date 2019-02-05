testing
testInheritedStylesAreCumulative
	graph add: #node with: #color -> #blue.
	graph add: #A.
	graph add: #node with: #shape -> #box.
	graph add: #B -> #C.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph nodeNamed: #B) color = #blue.
	self assert: (graph nodeNamed: #B) shape equals: #box.
	self assert: (graph nodeNamed: #C) color equals: #blue.
	self assert: (graph nodeNamed: #C) shape equals: #box