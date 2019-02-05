"
A PDPackageAnalyzerReverseTreeModel shows all users from a set of packages. Also you can see all type of the dependency, and browse them.

The window is initialized with a relation graph of package dependencies, with all the dependencies already compute.
"
Class {
	#name : #PDPackageAnalyzerReverseTreeModel,
	#superclass : #PDPackageTreeModel,
	#instVars : [
		'relationGraph',
		'packageLabel'
	],
	#category : 'Package-Dependencies-UI-Window'
}

{ #category : #specs }
PDPackageAnalyzerReverseTreeModel class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn:
			[ :col | 
			col
				newRow: [ :row | row add: #buttonRefresh ] height: 30;
				newRow: [ :row | 
							row
								add: #packageLabel;
								add: #extensionCheckBox ]
					height: 30;
				add: #tree ] yourself
]

{ #category : #'instance-creation' }
PDPackageAnalyzerReverseTreeModel class >> onRelationGraph: aRelationGraph [
	^ self new
		initializeWithRelationGraph: aRelationGraph;
		yourself
]

{ #category : #private }
PDPackageAnalyzerReverseTreeModel >> buildRoots [
	| collectionOfWrapper |
	collectionOfWrapper := relationGraph allDependentPackagesFromSeenPackages
		collect: [ :package | package asDependentPackageWrapperOn: relationGraph ].
	
	self tree roots: collectionOfWrapper asSortedCollection.
	self 
		treeWhenBuiltDo;
		updatePackageLabel.
]

{ #category : #'as yet unclassified' }
PDPackageAnalyzerReverseTreeModel >> initializePresenter [
	super initializePresenter.
	
	tree
		whenSelectedItemChanged: [ :item | 
			item
				ifNotNil: [ 
					self tree selectedItem browseInNautilus.
					tree menu: [ :aMenu | self loadMenuFor: item in: aMenu ] ] ].
]

{ #category : #initialization }
PDPackageAnalyzerReverseTreeModel >> initializeWidgets [
	super initializeWidgets.
	
	packageLabel := self newLabel text: 'Analysis of packages'.
]

{ #category : #initialization }
PDPackageAnalyzerReverseTreeModel >> initializeWithRelationGraph: aRelationGraph [
	relationGraph := aRelationGraph.
	self buildRoots.
]

{ #category : #accessing }
PDPackageAnalyzerReverseTreeModel >> packageLabel [
	^ packageLabel
]

{ #category : #actions }
PDPackageAnalyzerReverseTreeModel >> refresh [
		self isOpen ifTrue: [  
			self relationGraph refreshGraph.
			self buildRoots].
]

{ #category : #accessing }
PDPackageAnalyzerReverseTreeModel >> relationGraph [
	^ relationGraph
]

{ #category : #'as yet unclassified' }
PDPackageAnalyzerReverseTreeModel >> title [
	^ 'Package Dependencies Reverse Analysis'
]

{ #category : #private }
PDPackageAnalyzerReverseTreeModel >> treeWhenBuiltDo [	
	self tree
		whenBuiltDo: [ 
			tree
				rootNodeHolder: [ :item | 
					PDReversePackageNode new
						content: item;
						treeModelParent: self;
						packageTreeNautilus: self packageTreeNautilus;
						packageTreeNautilusUI: self packageTreeNautilusUI;
						cycle: false ] ]
	
]

{ #category : #private }
PDPackageAnalyzerReverseTreeModel >> updatePackageLabel [
	self packageLabel text: 'Analysis of ' , self tree roots size asString , ' package(s)'
]
