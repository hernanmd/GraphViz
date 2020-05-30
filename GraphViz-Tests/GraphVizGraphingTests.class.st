Class {
	#name : #GraphVizGraphingTests,
	#superclass : #GraphVizBaseTests,
	#category : #'GraphViz-Tests'
}

{ #category : #testing }
GraphVizGraphingTests >> testAnonymousSubGraph [
	graph subgraphDo: [ graph add: #A ].
	self assert: (graph dot lineNumber: 2) equals: '	{'.
	self assert: (graph dot lineNumber: 3) equals: '		A;'.
	self assert: (graph dot lineNumber: 4) equals: '	}'.
	self assert: (graph dot lineNumber: 5) equals: '}'
]

{ #category : #testing }
GraphVizGraphingTests >> testDirectedGraphWithOneEdge [
	graph beDirected.
	graph add: #A -> #B.
	self assert: (graph dot includesSubstring: '	A -> B;')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphToMorph [
	graph add: #A.
	self assert: graph asMorph height > 0
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphToXml [
	graph add: #A.
	graph add: #B -> #C.
	self
		should: [ Smalltalk globals includesKey: #XMLDOMParser ]
		description: 'Need YAXO package to run this test and use asXml feature of graphs'.
	self assert: graph asXml firstNode localName equals: #gxl
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithDoubleQuotedId [
	graph add: 'HI THERE'.
	self assert: (graph dot lineNumber: 2) equals: '	"HI THERE";'
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithEdgeAttribute [
	graph add: #edge with: #dir -> #both.
	self assert: (graph dot includesSubstring: 'edge [dir=both];')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithGraphAttribute [
	graph add: #graph with: #start -> #rand.
	self assert: (graph dot includesSubstring: 'graph [start=rand];')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithName [
	graph name: 'g'.
	self assert: (graph dot beginsWith: 'graph g {').
	self assert: graph dot last equals: $}
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithNodeAttribute [
	graph add: #node with: #shape -> #box.
	self assert: (graph dot includesSubstring: 'node [shape=box];')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithOneEdge [
	graph add: #A -> #B.
	self assert: (graph dot includesSubstring: '	A -- B;')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithOneNode [
	graph add: #A.
	self assert: (graph dot lineNumber: 2) equals: '	A;'
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithSimpleAttribute [
	graph at: #label put: #title.
	self assert: (graph dot lineNumber: 2) equals: '	label=title;'
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithSpecificNodeAttribute [
	graph add: #A with: #shape -> #box.
	self assert: (graph dot lineNumber: 2) equals: '	A [shape=box];'
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithSpecificNodeAttributes [
	graph
		add: #A
		with:
			{(#shape -> #box).
			(#fontname -> #trebuc)}.
	self
		assert: ((graph dot lineNumber: 2) includesSubstring: 'shape=box').
	self
		assert: ((graph dot lineNumber: 2) includesSubstring: 'fontname=trebuc')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithTwoEdgesDifferentNode [
	graph add: #A -> #B.
	graph add: #B -> #C.
	self assert: (graph dot includesSubstring: 'A -- B').
	self assert: (graph dot includesSubstring: 'B -- C')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithTwoEdgesFromSameNode [
	graph add: #A -> #B.
	graph add: #A -> #C.
	self assert: (graph dot includesSubstring: 'A -- B').
	self assert: (graph dot includesSubstring: 'A -- C')
]

{ #category : #testing }
GraphVizGraphingTests >> testGraphWithTwoNodes [
	graph add: #A.
	graph add: #B.
	self assert: (graph dot lineNumber: 2) equals: '	A;'.
	self assert: (graph dot lineNumber: 3) equals: '	B;'
]

{ #category : #testing }
GraphVizGraphingTests >> testSafeIds [
	self assert: (graph safeIdFor: #A) equals: #A.
	self assert: (graph safeIdFor: 10) equals: '10'.
	self assert: (graph safeIdFor: '"10"') equals: '"10"'.
	self
		assert: (graph safeIdFor: '<TABLE> </TABLE>')
		equals: '<TABLE> </TABLE>'.
	self assert: (graph safeIdFor: '10ABC') equals: '"10ABC"'.
	self assert: (graph safeIdFor: 'ABC DEF') equals: '"ABC DEF"'.
	self assert: (graph safeIdFor: 'ABC-DEF') equals: '"ABC-DEF"'
]

{ #category : #testing }
GraphVizGraphingTests >> testSimplestDirectedGraph [
	graph beDirected.
	self assert: (graph dot beginsWith: 'digraph {').
	self assert: graph dot last equals: $}
]

{ #category : #testing }
GraphVizGraphingTests >> testSimplestGraph [
	self assert: (graph dot beginsWith: 'graph {').
	self assert: graph dot last equals: $}
]

{ #category : #testing }
GraphVizGraphingTests >> testSubGraph [
	graph subgraph: #nested do: [ graph add: #A ].
	self assert: (graph dot lineNumber: 2) equals: '	subgraph nested {'.
	self assert: (graph dot lineNumber: 3) equals: '		A;'.
	self assert: (graph dot lineNumber: 4) equals: '	}'.
	self assert: (graph dot lineNumber: 5) equals: '}'
]
