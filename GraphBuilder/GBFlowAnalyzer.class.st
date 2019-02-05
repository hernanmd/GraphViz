Class {
	#name : #GBFlowAnalyzer,
	#superclass : #Object,
	#instVars : [
		'entries',
		'graph',
		'continuation'
	],
	#category : #'GraphBuilder-Log'
}

{ #category : #'instance-creation' }
GBFlowAnalyzer class >> on: aStream [
	^ self new
		initializeFromStream: aStream;
		yourself.
]

{ #category : #adding }
GBFlowAnalyzer >> add: aFlowEntry [
	entries add: aFlowEntry.
	continuation at: aFlowEntry currentCC put: aFlowEntry.
]

{ #category : #building }
GBFlowAnalyzer >> build [
	" Build unnamed graph "
	
	self build: 'Unnamed Graph'
]

{ #category : #building }
GBFlowAnalyzer >> build: graphName [

	self buildGraph: graphName.
	self buildTimeline.
	self buildBrowsing.
]

{ #category : #building }
GBFlowAnalyzer >> buildBrowsing [

	graph add: #node with: { #shape -> #box }.
	entries do: [ :each |
		graph add: #node with: { #label -> each type }.
		self graph rank: 't' , each uuid asString add: 'n' , each uuid asString ].
	entries do: [ :each |
		continuation at: each previousCC ifPresent: [ :previous |
			self graph add: ('n' , previous uuid asString) -> ('n' , each uuid asString) ] ].
]

{ #category : #building }
GBFlowAnalyzer >> buildGraph: graphName [

	graph := GraphViz new.
	graph
		beDirected;
		name: graphName;
		add: #graph with: { #overlap -> #scale. #concentrate -> true. #ranksep -> 0.25 };
		add: #edge with: { #arrowsize -> '1.0' }.

]

{ #category : #building }
GBFlowAnalyzer >> buildTimeline [

	graph add: #node with: { #shape -> #plaintext }.
	entries do: [ :each | 
		self graph add: 't' , each uuid asString with: { #label -> each timestamp time asString } ].
	entries allButFirst
		inject: entries first
		into: [ :previous :current |
			self graph add: ('t' , previous uuid asString) -> ('t' , current uuid asString).
			current ].

]

{ #category : #accessing }
GBFlowAnalyzer >> entries [
	^ entries
]

{ #category : #accessing }
GBFlowAnalyzer >> graph [
	graph isNil ifTrue: [ self build ].
	^ graph.
]

{ #category : #'initialize-release' }
GBFlowAnalyzer >> initialize [
	super initialize.
	entries := OrderedCollection new.
	continuation := Dictionary new.
]

{ #category : #'initialize-release' }
GBFlowAnalyzer >> initializeFromStream: aStream [
	[ aStream atEnd ] whileFalse: [ 
		self add: (GBFlowEntry 
			fromString: (aStream 
				upTo: Character lf)) ].
]
