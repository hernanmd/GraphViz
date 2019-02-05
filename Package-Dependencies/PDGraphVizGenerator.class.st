"
A PDGraphVizGenerator is a class able to generate a dot file to represent a graph.
"
Class {
	#name : #PDGraphVizGenerator,
	#superclass : #Object,
	#instVars : [
		'builder',
		'graphviz',
		'nameOfGraph'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDGraphVizGenerator class >> newWith: aContent named: aString [
	self subclassResponsibility
]

{ #category : #'build items' }
PDGraphVizGenerator >> buildGraphViz [
	graphviz := GraphViz new.
	graphviz
		beDirected;
		name: self nameOfGraph.
	graphviz add: #node with: {(#shape -> #box)}.
	graphviz add: #graph with: { (#label -> self nameOfGraph). (#fontsize -> 20) }.	
	
	self
		buildNodes;
		buildEdges.
]

{ #category : #accessing }
PDGraphVizGenerator >> builder [
	^ builder
]

{ #category : #accessing }
PDGraphVizGenerator >> graphviz [
	^ graphviz
]

{ #category : #accessing }
PDGraphVizGenerator >> nameOfGraph [
	^ nameOfGraph ifNil: [ 'UnamedGraph' ]
]

{ #category : #accessing }
PDGraphVizGenerator >> nameOfGraph: anObject [
	nameOfGraph := anObject
]

{ #category : #saving }
PDGraphVizGenerator >> openWith: extension [
	"make sure the .gv is generated and converted into a image format"
	graphviz openInWindowWith: extension
]

{ #category : #saving }
PDGraphVizGenerator >> saveDotFileAndGenerateForType: extension [
	^ graphviz generator makeNoWait: extension.
]
