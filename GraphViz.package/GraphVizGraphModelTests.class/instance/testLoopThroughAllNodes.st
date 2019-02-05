testing
testLoopThroughAllNodes
	| items |
	graph add: #A.
	graph add: #B.
	graph subgraphDo: [ graph add: #C -> #A ].
	items := OrderedCollection new.
	graph allNodesDo: [ :each | items add: each ].
	self assert: items size equals: 3