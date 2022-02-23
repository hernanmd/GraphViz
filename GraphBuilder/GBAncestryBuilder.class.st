"
Usage example

GBAncestryBuilder select.

"
Class {
	#name : #GBAncestryBuilder,
	#superclass : #Object,
	#instVars : [
		'repository',
		'graph',
		'versions'
	],
	#category : #'GraphBuilder-Monticello'
}

{ #category : #'instance creation' }
GBAncestryBuilder class >> on: aRepository [
	^self new
		repository: aRepository;
		yourself.
]

{ #category : #'instance creation' }
GBAncestryBuilder class >> select [
	|  repo types index |
	
	types := MCRepositoryGroup default repositories.
	index := UIManager default 
					chooseFrom: (types collect: [ : ea | ea description ])
					title: 'Choose Repository'.
	(repo := index = 0 ifFalse: [ types at: index ]) notNil 
		ifTrue: [ ^ ((self on: repo) build: repo description) asOutputType: #png ]
]

{ #category : #generating }
GBAncestryBuilder >> asOutputType: aSymbol [
	" Write the receiver's graph in aSymbol format, e.x. #png "

	self graph asOutputType: aSymbol
]

{ #category : #actions }
GBAncestryBuilder >> build [
	self initializeGraph; initializeVersions.
	self buildNodes; buildEdgesAncestry; buildEdgesDependencies.
]

{ #category : #actions }
GBAncestryBuilder >> build: graphName [

	self 
		initializeGraph: graphName; 
		initializeVersions.
	self 
		buildNodes; 
		buildEdgesAncestry; 
		buildEdgesDependencies.
]

{ #category : #building }
GBAncestryBuilder >> buildEdges: aCollection [ 

	versions
		do: [ :version |
				version setAncestors: Set new.
				version info ancestors do: [ :ancestor |
					(versions like: (GBVersion info: ancestor))
						ifNotNil: [ :each | version ancestors add: each ] ].
				version setDependencies: Set new.
				version version ifNotNil: [ :ver |
					ver dependencies do: [ :dependency |
						(versions like: (GBVersion info: dependency versionInfo))
							ifNotNil: [ :each | version dependencies add: each ] ] ] ]
		displayingProgress: 'Building Edges'.
]

{ #category : #actions }
GBAncestryBuilder >> buildEdgesAncestry [
	self versions 
		do: [ :version |
			version ancestors do: [ :ancestor |
				self graph 
					add: ancestor uid -> version uid
					with: { } ] ]
		displayingProgress: 'Writing Ancestry Edges'.
]

{ #category : #actions }
GBAncestryBuilder >> buildEdgesDependencies [

	| roots ranked |

	roots := self versions copy.
	ranked := Set new.
	self versions 
		do: [ : version |
			version dependencies do: [ :each |
				roots remove: each ifAbsent: nil ] ]
		displayingProgress: 'Searching Dependency Root'.

	roots asSortedCollection 
		do: [ :root |
			root deep in: [ :dependencies |
				dependencies size > 1 ifTrue: [
					self graph
						rank: root uid
						add: (Array streamContents: [ :stream |
							dependencies do: [ :each | 
								(ranked includes: each) ifFalse: [
									stream nextPut: each uid.
									ranked add: each ] ] ]) ] ] ]
		displayingProgress: 'Writing Dependency Edges'.
]

{ #category : #actions }
GBAncestryBuilder >> buildNodes [

	self versions 
		do: [ :version | self graph add: version uid with: { 'label' -> version label } ]
		displayingProgress: 'Writing Nodes'.
]

{ #category : #building }
GBAncestryBuilder >> buildNodes: aCollection [ 

	versions copy 
		do: [ : version |
				versions addAll: 
					(version info allAncestors collect: [ :ancestor | GBVersion info: ancestor ]) ]
		displayingProgress: 'Building Nodes'.

]

{ #category : #'accessing-readonly' }
GBAncestryBuilder >> graph [
	^graph
]

{ #category : #private }
GBAncestryBuilder >> initializeGraph [
	graph := GraphViz new.
	graph
		beDirected;
		add: 'graph' with: { 'overlap' -> 'scale'. 'concentrate' -> 'true'. 'ranksep' -> '0.25'. 'label' -> self repository asString };
		add: 'edge' with: { 'arrowsize' -> '1.0' };
		add: 'node' with: { 'shape' -> 'Mrecord' };	
		yourself.
]

{ #category : #private }
GBAncestryBuilder >> initializeGraph: graphName [

	graph := GraphViz new.
	graph
		name: graphName;
		beDirected;
		add: 'graph' with: { 'overlap' -> 'scale'. 'concentrate' -> 'true'. 'ranksep' -> '0.25'. 'label' -> self repository asString };
		add: 'edge' with: { 'arrowsize' -> '1.0' };
		add: 'node' with: { 'shape' -> 'Mrecord' };	
		yourself.
]

{ #category : #private }
GBAncestryBuilder >> initializeVersions [

	versions := Set new.
	self readVersions: versions.
	self buildNodes: versions.
	self buildEdges: versions.
]

{ #category : #building }
GBAncestryBuilder >> readVersions: aCollection [ 

	self repository readableFileNames 
		do: [ : filename | versions add: (GBVersion repository: self repository filename: filename) ]
		displayingProgress: 'Reading Versions'.
	^ versions
]

{ #category : #accessing }
GBAncestryBuilder >> repository [
	^repository
]

{ #category : #accessing }
GBAncestryBuilder >> repository: aRepository [
	repository := aRepository
]

{ #category : #'accessing-readonly' }
GBAncestryBuilder >> versions [
	^versions
]
