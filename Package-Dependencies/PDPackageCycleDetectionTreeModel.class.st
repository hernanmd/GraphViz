"
A PDPackageDetectCycleTreeModel shows all cycles among packages from a graph of dependencies.
"
Class {
	#name : #PDPackageCycleDetectionTreeModel,
	#superclass : #PDPackageTreeModel,
	#instVars : [
		'analysis',
		'cycles',
		'cyclesLabel',
		'filter',
		'buttonReversed'
	],
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #specs }
PDPackageCycleDetectionTreeModel class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn:
			[ :col | 
			col
				newRow: [ :row | 
							row
								add: #buttonReversed;
								add: #buttonRefresh ]
					height: 30;
				newRow: [ :row | 
							row
								add: #cyclesLabel;
								add: #extensionCheckBox ]
					height: 30;
				add: #tree ] yourself
]

{ #category : #'instance-creation' }
PDPackageCycleDetectionTreeModel class >> onPackagesMatch: match [
	^ (self 
		onPackagesNamed:
			(RPackageOrganizer default packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) ) 
]

{ #category : #'instance-creation' }
PDPackageCycleDetectionTreeModel class >> onPackagesNamed: aCollection [

	^ self new 
		initializeWithPackageName: aCollection; 
		yourself
]

{ #category : #'instance-creation' }
PDPackageCycleDetectionTreeModel class >> system [

	^ self onPackagesNamed: (RPackageOrganizer default packages collect: [ :package | package packageName asString ])
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> analysis [
	^ analysis
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> analysis: anObject [
	analysis := anObject
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> buildRoots [
	self tree
		roots: cycles;
		whenBuiltDo: [ 
					tree
						rootNodeHolder: [ :item | 
							PDCycleNode new
								content: item;
								treeModelParent: self;
								packageTreeNautilus: self packageTreeNautilus;
								packageTreeNautilusUI: self packageTreeNautilusUI;
								cycle: true ] ].
	self cyclesLabel
		label: 'Analysis of ' , self cycles size asString , ' cycles'.
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> buttonReversed [
	^ buttonReversed
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> cycles [
	^ cycles
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> cycles: aCollectionOfCycles [
	cycles := aCollectionOfCycles sorted: [ :a :b | a size > b size ].
	self buildRoots.
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> cyclesLabel [
	^ cyclesLabel
]

{ #category : #protocol }
PDPackageCycleDetectionTreeModel >> extent [
	^ 1000@600
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> filter [
	^ filter
]

{ #category : #actions }
PDPackageCycleDetectionTreeModel >> filterWithPackages [
	
	self cycles: (self analysis cyclesWithAtLeast: filter)
]

{ #category : #'as yet unclassified' }
PDPackageCycleDetectionTreeModel >> filterWithPackages: aCollectionOfPDPackage [
	filter := aCollectionOfPDPackage.
	self cycles: (self analysis cyclesWithAtLeast: filter)
]

{ #category : #initialization }
PDPackageCycleDetectionTreeModel >> initializePresenter [
	super initializePresenter.
	
	buttonReversed action: [ self reversedRoots  ].
	
	
	
	tree
		whenSelectedItemChanged: [ :item | 
			item
				ifNotNil: [ 
					self tree selectedItem browseInNautilus.
					tree menu: [ :aMenu | self loadMenuFor: item in: aMenu ] ] ]
]

{ #category : #initialization }
PDPackageCycleDetectionTreeModel >> initializeWidgets [
	super initializeWidgets.
	
	cyclesLabel := self newLabel
			label: 'Analysis of cycles'.
	
	buttonReversed := self newButton
			help: 'Reversed the order of cycles';
			label: 'Sort by length'.
	
		
	
	
		
]

{ #category : #initialization }
PDPackageCycleDetectionTreeModel >> initializeWithPackageName: aCollection [
	
	self analysis:  (PDPackageCycleDetector onPackagesNamed: aCollection) runAlgorithm.
	
	self cycles: self analysis cycles.
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> packageTreeNautilus: anObject [
	packageTreeNautilus := anObject
]

{ #category : #actions }
PDPackageCycleDetectionTreeModel >> refresh [
	self analysis refresh.
	self filter ifNil: [ self cycles: self analysis cycles ]
		ifNotNil: [ self cycles: (self analysis cyclesWithAtLeast: filter) ].
	self buildRoots
]

{ #category : #accessing }
PDPackageCycleDetectionTreeModel >> reversedRoots [
	self tree roots: (self tree roots reversed).
]

{ #category : #protocol }
PDPackageCycleDetectionTreeModel >> title [
	^ 'Cycles analysis'
]
