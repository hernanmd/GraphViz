"
A simple CompasableModel to add new packages to the current package dependencies analysis.
It implies to be open from a PDPackageAnalyzerWindowPackageDependencies instance.
"
Class {
	#name : #PDAddPackageModel,
	#superclass : #ComposableModel,
	#instVars : [
		'packageList',
		'buttonAddPackage',
		'packageAnalyzerTreeModel'
	],
	#category : 'Package-Dependencies-UI-Window'
}

{ #category : #specs }
PDAddPackageModel class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn:
			[ :col | 
			col
				add: #packageList;
				add: #buttonAddPackage height: 30
				] yourself
]

{ #category : #protocol }
PDAddPackageModel >> actionOnAddPackage [
	| relationGraph packagesToAdd |
	buttonAddPackage
		action: [ 
			self selectedItemsFromPackageList
				ifNotEmpty: [ 
					relationGraph := self packageAnalyzerTreeModel relationGraph.
					packagesToAdd := self selectedItemsFromPackageList
						collect: [ :packageName | (PDPackage on: (RPackageSet named: packageName)) beSeen ].
					relationGraph addPackages: packagesToAdd.
					self packageAnalyzerTreeModel
						refresh;
						resetDefaultSettings.
					self delete ] ]
]

{ #category : #'as yet unclassified' }
PDAddPackageModel >> buildList [
	| packagesAdded packagesNotAdded |
	packagesAdded := self packageAnalyzerTreeModel seenPackagesName.
	packagesNotAdded := self systemPackages.
	packagesNotAdded removeAll: packagesAdded.
	packageList items: packagesNotAdded.
]

{ #category : #accessing }
PDAddPackageModel >> buttonAddPackage [
	^ buttonAddPackage
]

{ #category : #'as yet unclassified' }
PDAddPackageModel >> initialExtent [
	^ (600@600)
]

{ #category : #initialization }
PDAddPackageModel >> initializePresenter [
	self actionOnAddPackage
]

{ #category : #initialization }
PDAddPackageModel >> initializeWidgets [
	
	packageList := self newList
		multiSelection: true;
		yourself.
	
	buttonAddPackage := self newButton
		help: 'Add these packages to the current analysis';
		label: 'Add packages';
		icon: (Smalltalk ui icons iconNamed: #addIcon);
		yourself.
]

{ #category : #'instance creation' }
PDAddPackageModel >> open [
	^ self openWithSpec
]

{ #category : #accessing }
PDAddPackageModel >> packageAnalyzerTreeModel [
	^ packageAnalyzerTreeModel
]

{ #category : #accessing }
PDAddPackageModel >> packageAnalyzerTreeModel: aPackageAnalyzerTreeModel [
	packageAnalyzerTreeModel := aPackageAnalyzerTreeModel.
	self buildList
]

{ #category : #accessing }
PDAddPackageModel >> packageList [
	^ packageList
]

{ #category : #initialization }
PDAddPackageModel >> selectedItemsFromPackageList [
	^ self packageList selectedItems
]

{ #category : #accessing }
PDAddPackageModel >> systemPackages [
	^ (RPackageOrganizer default packages collect: [ :package | package packageName asString ] )asSortedCollection
]

{ #category : #protocol }
PDAddPackageModel >> title [
	^ 'Choose packages to add'
]
