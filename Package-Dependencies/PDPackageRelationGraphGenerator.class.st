"
A PDGraphVizGenerator is a class able to generate a dot file from a relationGraph (PDPackageRelationGraph)
"
Class {
	#name : #PDPackageRelationGraphGenerator,
	#superclass : #PDGraphVizGenerator,
	#instVars : [
		'relationGraph'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDPackageRelationGraphGenerator class >> newWith: aRelationGraph named: aString [

	| generator |
	generator := self new.
	generator relationGraph: aRelationGraph.
	generator nameOfGraph: aString.
	generator buildGraphViz.
	^ generator
]

{ #category : #'build items' }
PDPackageRelationGraphGenerator >> buildEdges [
	relationGraph packages
		do: [ :package | 
			package dependencies
				do: [ :dependency | 
					graphviz
						add: dependency source packageName -> dependency target packageName
						with: {(#label -> dependency mySize)} ] ]
		displayingProgress: 'Building edges'
]

{ #category : #'build items' }
PDPackageRelationGraphGenerator >> buildNodes [
	relationGraph seenPackages do: [ :package | graphviz add: package packageName ] displayingProgress: 'Building nodes'
]

{ #category : #accessing }
PDPackageRelationGraphGenerator >> relationGraph [
	^ relationGraph
]

{ #category : #accessing }
PDPackageRelationGraphGenerator >> relationGraph: anObject [
	relationGraph := anObject
]
