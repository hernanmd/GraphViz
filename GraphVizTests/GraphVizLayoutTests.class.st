Class {
	#name : #GraphVizLayoutTests,
	#superclass : #GraphVizBaseTests,
	#category : #GraphVizTests
}

{ #category : #testing }
GraphVizLayoutTests >> testGetCoordinatesForEdges [
	| edge |
	edge := graph add: #A -> #B.
	graph doLayout.
	self assert: edge vertices size equals: 4.
	self assert: edge vertices first isPoint.
	self assert: edge vertices first x > 0.
	self assert: edge vertices first y > 0
]

{ #category : #testing }
GraphVizLayoutTests >> testGetCoordinatesForNodes [
	| node |
	graph add: #A -> #B.
	graph doLayout.
	node := graph nodeNamed: #A.
	self assert: node x > 0.
	self assert: node y > 0.
	self assert: node height > 0.
	self assert: node width > 0
]

{ #category : #testing }
GraphVizLayoutTests >> testGetCoordinatesForNodesDefinedInSubgraph [
	| node |
	graph subgraphDo: [ node := graph add: #A ].
	graph doLayout.
	self assert: node x > 0.
	self assert: node y > 0.
	self assert: node height > 0.
	self assert: node width > 0
]
