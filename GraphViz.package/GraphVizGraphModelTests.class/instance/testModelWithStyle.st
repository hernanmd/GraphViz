testing
testModelWithStyle
	graph add: #node with: #color -> #blue.
	self assert: graph nodes isEmpty.
	self assert: graph styles size equals: 1