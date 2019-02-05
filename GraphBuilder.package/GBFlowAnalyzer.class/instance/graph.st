accessing
graph
	graph isNil ifTrue: [ self build ].
	^ graph.