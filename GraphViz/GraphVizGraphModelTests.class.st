Class {
	#name : #GraphVizGraphModelTests,
	#superclass : #GraphVizBaseTests,
	#category : #'GraphViz-Tests'
}

{ #category : #testing }
GraphVizGraphModelTests >> testAccessAllEdgesViaRootGraph [
	graph add: #A -> #B.
	graph subgraphDo: [ graph add: #B -> #C ].
	graph add: 123 -> 456.
	self assert: (graph edgeNamed: #A -> #B) notNil.
	self assert: (graph edgeNamed: #B -> #C) notNil.
	self assert: (graph edgeNamed: '123' -> '456') notNil
]

{ #category : #testing }
GraphVizGraphModelTests >> testAccessAllNodesViaRootGraph [
	graph add: #A.
	graph subgraphDo: [ graph add: #B ].
	graph add: 123.
	self assert: (graph nodeNamed: #A) notNil.
	self assert: (graph nodeNamed: #B) notNil.
	self assert: (graph nodeNamed: #C) isNil.
	self assert: (graph nodeNamed: '123') notNil
]

{ #category : #testing }
GraphVizGraphModelTests >> testInheritedStyle [
	graph add: #node with: #color -> #blue.
	graph add: #A.
	graph add: #B.
	graph add: #C with: #color -> #yellow.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph nodeNamed: #B) color equals: #blue.
	self assert: (graph nodeNamed: #C) color equals: #yellow
]

{ #category : #testing }
GraphVizGraphModelTests >> testInheritedStyleCascadesThroughSubgraphs [
	graph
		add: #node
		with:
			{(#color -> #blue).
			(#shape -> #ellipse)}.
	graph
		subgraphDo: [ graph add: #node with: #shape -> #box.
			graph add: #A ].
	graph add: #B.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph nodeNamed: #A) shape equals: #box.
	self assert: (graph nodeNamed: #B) color equals: #blue.
	self assert: (graph nodeNamed: #B) shape equals: #ellipse
]

{ #category : #testing }
GraphVizGraphModelTests >> testInheritedStylesAreCumulative [
	graph add: #node with: #color -> #blue.
	graph add: #A.
	graph add: #node with: #shape -> #box.
	graph add: #B -> #C.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph nodeNamed: #B) color = #blue.
	self assert: (graph nodeNamed: #B) shape equals: #box.
	self assert: (graph nodeNamed: #C) color equals: #blue.
	self assert: (graph nodeNamed: #C) shape equals: #box
]

{ #category : #testing }
GraphVizGraphModelTests >> testInheritedStylesAreDistinctForNodesAndEdges [
	graph add: #node with: #color -> #blue.
	graph add: #edge with: #color -> #yellow.
	graph add: #A.
	graph add: #A -> #B.
	self assert: (graph nodeNamed: #A) color equals: #blue.
	self assert: (graph edgeNamed: #A -> #B) color = #yellow
]

{ #category : #testing }
GraphVizGraphModelTests >> testInheritedStylesMaintainedIfNodesPutIntoSubgraph [
	graph := GraphViz new
		add: #node with: #fontsize -> 16;
		add: #A;
		add: #node with: #fontsize -> 10;
		yourself.
	graph subgraphDo: [ graph add: #A ].
	self assert: (graph nodeNamed: #A) fontSize equals: 16
]

{ #category : #testing }
GraphVizGraphModelTests >> testLoopThroughAllEdges [
	| items |
	graph add: #A -> #B.
	graph subgraphDo: [ graph add: #C -> #A ].
	items := OrderedCollection new.
	graph allEdgesDo: [ :each | items add: each ].
	self assert: items size equals: 2
]

{ #category : #testing }
GraphVizGraphModelTests >> testLoopThroughAllNodes [
	| items |
	graph add: #A.
	graph add: #B.
	graph subgraphDo: [ graph add: #C -> #A ].
	items := OrderedCollection new.
	graph allNodesDo: [ :each | items add: each ].
	self assert: items size equals: 3
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelContainsAttributes [
	graph addAttribute: #A -> #B.
	self assert: graph attributes size equals: 1.
	self assert: graph attributes first key equals: #A.
	self assert: graph attributes first value equals: #B
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelContainsEdges [
	graph add: #A -> #B.
	self assert: graph edges size equals: 1.
	self assert: graph edges first id equals: #A -> #B.
	self assert: graph nodes size equals: 2.
	self assert: graph nodes first id equals: #A.
	self assert: graph nodes second id equals: #B
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelContainsManyNodesWhenUsingEdgesWithNestedAssociations [
	graph add: #A -> #B -> #C.
	self assert: graph nodes size equals: 3
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelContainsNodes [
	graph add: #A.
	self assert: graph nodes size equals: 1.
	self assert: graph nodes first id equals: #A.
	graph add: #B.
	self assert: graph nodes size = 2.
	self assert: graph nodes second id equals: #B
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelContainsSubgraphs [
	graph subgraph: #foo do: [ graph add: #A ].
	self assert: graph nodes isEmpty.
	self assert: graph subgraphs size equals: 1.
	self assert: graph subgraphs first id equals: #foo.
	self assert: graph subgraphs first nodes size equals: 1.
	self assert: graph subgraphs first nodes first id equals: #A
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelRecordsOnlyUniqueNodes [
	| newNode |
	graph add: #A.
	self assert: graph nodes size equals: 1.
	self assert: graph nodes first id equals: #A.
	newNode := graph add: #A.
	self assert: graph nodes size = 1.
	self assert: newNode equals: (graph nodeNamed: #A)
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelRecordsOnlyUniqueNodesEvenInSubgraphs [
	graph add: #A.
	graph subgraphDo: [ graph add: #A ].
	self assert: graph nodes size equals: 1.
	self assert: graph subgraphs first nodes size equals: 1.
	self assert: graph nodes first = graph subgraphs first nodes first
]

{ #category : #testing }
GraphVizGraphModelTests >> testModelWithStyle [
	graph add: #node with: #color -> #blue.
	self assert: graph nodes isEmpty.
	self assert: graph styles size equals: 1
]

{ #category : #testing }
GraphVizGraphModelTests >> testObjectsHaveAttributes [
	graph add: #A with: #label -> 'A label'.
	self assert: graph nodes first attributes size equals: 1.
	self assert: (graph nodes first attributes at: #label) = 'A label'.
	graph
		add: #B
		with:
			{(#foo -> #bar).
			(#doo -> #boo)}.
	self assert: graph nodes second attributes size equals: 2
]

{ #category : #testing }
GraphVizGraphModelTests >> testSubgraphInSubgraphs [
	graph
		subgraph: #foo
		do: [ graph subgraph: #bar do: [ graph add: #A ] ].
	self assert: graph nodes isEmpty.
	self assert: graph subgraphs size equals: 1.
	self assert: graph subgraphs first id equals: #foo.
	self assert: graph subgraphs first nodes isEmpty.
	self assert: graph subgraphs first subgraphs size equals: 1.
	self assert: graph subgraphs first subgraphs first id equals: #bar.
	self
		assert: graph subgraphs first subgraphs first nodes size
		equals: 1.
	self
		assert: graph subgraphs first subgraphs first nodes first id
		equals: #A
]

{ #category : #testing }
GraphVizGraphModelTests >> testSubgraphsVsGraphs [
	self assert: graph isGraph.
	self shouldnt: [ graph isSubgraph ].
	graph subgraph: #foo do: [  ].
	self assert: graph subgraphs first isGraph.
	self assert: graph subgraphs first isSubgraph.
	graph subgraphDo: [ graph rank: #same ].
	self assert: graph attributes isEmpty.
	self assert: graph subgraphs last attributes size = 1
]
