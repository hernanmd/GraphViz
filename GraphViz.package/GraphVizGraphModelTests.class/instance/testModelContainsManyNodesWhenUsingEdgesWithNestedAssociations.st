testing
testModelContainsManyNodesWhenUsingEdgesWithNestedAssociations
	graph add: #A -> #B -> #C.
	self assert: graph nodes size equals: 3