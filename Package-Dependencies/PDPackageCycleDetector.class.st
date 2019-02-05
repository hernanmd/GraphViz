"
I'm able to detect all the cycles in a package dependency graph.

Analysis is done in three steps: build the dependency graph, isolating the strongly connected components (SCC), and for each SCC detect all the elementary cycles.

Use the message runAlgorithm to run the algorithm to retrieve the elementary cycles in the package dependency graph.

 At the end, all the cycles are in the collection ""cycles"".
"
Class {
	#name : #PDPackageCycleDetector,
	#superclass : #Object,
	#instVars : [
		'relation',
		'sccs',
		'cycles',
		'visitedNodes',
		'queue'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #'instance-creation' }
PDPackageCycleDetector class >> collections [
	^ (PDPackageCycleDetector onPackagesNamed: #('Collections-Abstract' 'Collections-Arithmetic' 'Collections-Arrayed' 'Collections-Atomic' 'Collections-Native' 'Collections-Sequenceable' 'Collections-Stack' 'Collections-Streams' 'Collections-Strings' 'Collections-Support' 'Collections-Traits' 'Collections-Unordered' 'Collections-Weak')) runAlgorithm.
]

{ #category : #'instance-creation' }
PDPackageCycleDetector class >> morphic [
	^ (PDPackageCycleDetector onPackagesNamed: #('Morphic-Base' 'Morphic-Core' 'Morphic-Examples' 'MorphicTests' 'Spec-MorphicAdapters')) runAlgorithm.
]

{ #category : #'instance-creation' }
PDPackageCycleDetector class >> new [
	^ PDPackageCycleDetector onPackagesNamed: #()
]

{ #category : #'instance-creation' }
PDPackageCycleDetector class >> onPackages: aCollection [
	^ self basicNew initializeWithRPackageSet: aCollection; yourself
]

{ #category : #'instance-creation' }
PDPackageCycleDetector class >> onPackagesNamed: aCollection [
	^ self onPackages: (aCollection collect: [ :each | RPackageSet named: each ])
]

{ #category : #'instance-creation' }
PDPackageCycleDetector class >> system [
	^ (PDPackageCycleDetector onPackagesNamed: (RPackageOrganizer default packages collect: [ :package | package packageName asString ])) runAlgorithm.
]

{ #category : #adding }
PDPackageCycleDetector >> addCycle: aPDPackageCycle [
	cycles add: aPDPackageCycle
]

{ #category : #adding }
PDPackageCycleDetector >> addVisitedNodes: aNode [ 
	visitedNodes add: aNode
]

{ #category : #actions }
PDPackageCycleDetector >> buildCycleUntil: children [
	| aPackageCycle currentNode |
	aPackageCycle := PDPackageCycle new.
	currentNode := children.
	[ currentNode isNil ]
		whileFalse: [ 
			aPackageCycle addPackage: currentNode.
			currentNode := currentNode bfsParent ].
	(self cycleAlreadyFound: aPackageCycle)
		ifFalse: [ 
			aPackageCycle reversedCycle.
			self addCycle: aPackageCycle ]
]

{ #category : #accessing }
PDPackageCycleDetector >> childrensFrom: stronglyConnectedComponents for: aNode [
	^ stronglyConnectedComponents successors: aNode
]

{ #category : #testing }
PDPackageCycleDetector >> cycleAlreadyFound: aPackageCycle [
	^ cycles anySatisfy: [ :cycle | cycle = aPackageCycle ]
]

{ #category : #accessing }
PDPackageCycleDetector >> cycles [
	^ cycles sorted: [ :a :b | a size < b size ]
]

{ #category : #accessing }
PDPackageCycleDetector >> cycles: anObject [
	cycles := anObject
]

{ #category : #accessing }
PDPackageCycleDetector >> cyclesWith: aPDPackage [
	^ cycles select: [ :cycle |
			cycle isInCycle: aPDPackage
		 ]
]

{ #category : #accessing }
PDPackageCycleDetector >> cyclesWithAtLeast: aCollectionOfPDPackage [
	^ cycles select: [ :cycle | cycle isAtLeastInCycle: aCollectionOfPDPackage ]
]

{ #category : #actions }
PDPackageCycleDetector >> dequeue [
	| aNode |
	aNode := queue nextOrNil.
	aNode ifNotNil: [ aNode inStack: false ].
	^ aNode
]

{ #category : #actions }
PDPackageCycleDetector >> enqueue: aNode [
	queue nextPut: aNode
]

{ #category : #actions }
PDPackageCycleDetector >> findAllCyclesFrom: stronglyConnectedComponents for: package [
	| parents |
	self initializeVisitedNodes.
	parents := self parentsFrom: stronglyConnectedComponents For: package.
	self initializeQueueWith: package.
	 [ parents isEmpty ] whileFalse: [ self startBfsFrom: stronglyConnectedComponents For: parents ]
]

{ #category : #actions }
PDPackageCycleDetector >> findCycles: stronglyConnectedComponents [
	stronglyConnectedComponents packages
		do: [ :package | 
			self findAllCyclesFrom: stronglyConnectedComponents for: package 
			]
]

{ #category : #initialization }
PDPackageCycleDetector >> initialize [
	super initialize.
	cycles := SortedCollection new.
	sccs := OrderedCollection new.
]

{ #category : #initialization }
PDPackageCycleDetector >> initializeQueueWith: package [

	package bfsParent: nil.	
	package inStack: true.
	queue := WaitfreeQueue new.
	queue nextPut: package
]

{ #category : #initialization }
PDPackageCycleDetector >> initializeVisitedNodes [
	
	visitedNodes := Set new.

]

{ #category : #initialization }
PDPackageCycleDetector >> initializeWithRPackageSet: aCollection [
	relation := PDPackageRelationGraph onPackages: (aCollection collect: [ :each | PDPackage on: each ]).
	cycles := OrderedCollection new.
	self relation build.
	sccs := PDTarjanAlgorithm new
		run: self relation;
		stronglyConnectedComponents
]

{ #category : #testing }
PDPackageCycleDetector >> isVisitedOrInQueue: aNode [
	^ (visitedNodes includes: aNode) or: [ aNode isInStack ]
]

{ #category : #accessing }
PDPackageCycleDetector >> parentsFrom: stronglyConnectedComponents For: aNode [
	^ stronglyConnectedComponents predecessors: aNode
]

{ #category : #accessing }
PDPackageCycleDetector >> refresh [
	self relation refreshGraph.
	self 
		reset;
		runAlgorithm.
]

{ #category : #accessing }
PDPackageCycleDetector >> relation [
	^ relation
]

{ #category : #accessing }
PDPackageCycleDetector >> relation: aRelation [
	relation := aRelation
]

{ #category : #accessing }
PDPackageCycleDetector >> reset [
	cycles := SortedCollection new.
	visitedNodes := nil.
	queue := nil
]

{ #category : #actions }
PDPackageCycleDetector >> runAlgorithm [
	self stronglyConnectedComponents
		do: [ :scc | self findCycles: scc ]
		displayingProgress: 'finding cycles'
]

{ #category : #actions }
PDPackageCycleDetector >> startBfsFrom: stronglyConnectedComponents For: parents [
	| dequeue childrens |
	dequeue := self dequeue.
	childrens := self childrensFrom: stronglyConnectedComponents for: dequeue.
	childrens
		do: [ :children | 
			(self isVisitedOrInQueue: children)
				ifFalse: [ 
					children bfsParent: dequeue.
					self enqueue: children ].
			(parents includes: children)
				ifTrue: [ 
					self buildCycleUntil: children.
					parents remove: children ] ].
	self addVisitedNodes: dequeue
]

{ #category : #accessing }
PDPackageCycleDetector >> stronglyConnectedComponents [
	^ sccs
]

{ #category : #accessing }
PDPackageCycleDetector >> visitedNodes [
	^ visitedNodes
]
