testing
testLoopThroughAllEdges
	| items |
	graph add: #A -> #B.
	graph subgraphDo: [ graph add: #C -> #A ].
	items := OrderedCollection new.
	graph allEdgesDo: [ :each | items add: each ].
	self assert: items size equals: 2