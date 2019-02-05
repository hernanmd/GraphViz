"
A PDPackageRelationGraphDiff do the diff between two PDPackageRelationGraph (an older and a newer) to detect :

 - which packages added/removed : packagesDiff.
 - which dependent packages added/removed from a package : dependentPackagesDiff.
 - which dependencies added/removed from a dependent package.
"
Class {
	#name : #PDPackageRelationGraphDiff,
	#superclass : #Object,
	#instVars : [
		'oldRelationGraph',
		'newRelationGraph',
		'packagesDiff',
		'dependentPackagesDiff'
	],
	#category : 'Package-Dependencies-Diff'
}

{ #category : #private }
PDPackageRelationGraphDiff class >> loadFrom: aSerializeFile [ 
	^ self new
		oldRelationGraph: (FLMaterializer materializationFromFileNamed: aSerializeFile).
]

{ #category : #private }
PDPackageRelationGraphDiff class >> loadFrom: aSerializeFile with: newRelationGraph [
	^ (PDPackageRelationGraphDiff new)
		oldRelationGraph: (FLMaterializer materializationFromFileNamed: aSerializeFile);
		newRelationGraph: newRelationGraph
]

{ #category : #adding }
PDPackageRelationGraphDiff >> addNewDependentPackage: package from: parent [
	^ dependentPackagesDiff
		add:
			((PDDependentPackageItemDiff
				newWith: package)
				beNew;
				parent: parent;
				diff: self);
		yourself
]

{ #category : #adding }
PDPackageRelationGraphDiff >> addNewPackage: seenPackage [
	^ packagesDiff
		add:
			((PDPackageItemDiff newWith: seenPackage)
				beNew;
				diff: self);
		yourself
]

{ #category : #adding }
PDPackageRelationGraphDiff >> addRemovedDependentPackage: package from: parent [
	^ dependentPackagesDiff
		add:
			((PDDependentPackageItemDiff
				newWith: package)
				beRemoved;
				parent: parent;
				diff: self);
		yourself
]

{ #category : #adding }
PDPackageRelationGraphDiff >> addRemovedPackage: seenPackage [
	^ packagesDiff
		add:
			((PDPackageItemDiff newWith: seenPackage)
				beRemoved;
				diff: self);
		yourself
]

{ #category : #adding }
PDPackageRelationGraphDiff >> addUndeterminateDependentPackage: aPackage from: parent [
	^ dependentPackagesDiff
		add:
				((PDDependentPackageItemDiff newWith: aPackage)
						beUnderteminate;
						parent: parent;
						diff: self);
		yourself
]

{ #category : #adding }
PDPackageRelationGraphDiff >> addUndeterminatePackage: aPackage [
	^ packagesDiff
		add:
			((PDPackageItemDiff newWith: aPackage)
				beUnderteminate;
				diff: self);
				yourself
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> dependentPackagesDiff [
	^ dependentPackagesDiff
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> dependentPackagesDiffNew [
	^ dependentPackagesDiff select: [ :each | each isNew ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> dependentPackagesDiffRemoved [
	^ dependentPackagesDiff select: [ :each | each isRemoved ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> dependentPackagesDiffUnderteminate [
	^ dependentPackagesDiff select: [ :each | each isUnderteminate ]
]

{ #category : #initialization }
PDPackageRelationGraphDiff >> initialize [
	packagesDiff := OrderedCollection new.
	dependentPackagesDiff := OrderedCollection new.
]

{ #category : #searching }
PDPackageRelationGraphDiff >> lookUpForNewDependentPackages: newDependentPackages with: oldDependentPackages from: aPackage [
	
	| newDependent |
	newDependent := newDependentPackages reject: [ :package | oldDependentPackages includes: package ].
	newDependent do: [ :each | self addNewDependentPackage: each from: aPackage ].
]

{ #category : #searching }
PDPackageRelationGraphDiff >> lookUpForNewPackages [
			
	| newPackages |
	newPackages := newRelationGraph seenPackages reject: [ :package | oldRelationGraph includesSeenPackage: package ].
	newPackages do: [ :each | self addNewPackage: each ].
]

{ #category : #searching }
PDPackageRelationGraphDiff >> lookUpForRemovedDependentPackages: oldDependentPackages with: newDependentPackages from: aPackage [

	| removed |
	removed := oldDependentPackages reject: [ :package | newDependentPackages includes: package ].
	removed do: [ :each | self addRemovedDependentPackage: each from: aPackage ].
]

{ #category : #searching }
PDPackageRelationGraphDiff >> lookUpForRemovedPackages [
	| old |
	old := oldRelationGraph seenPackages reject: [ :each |  newRelationGraph includesSeenPackage: each ].	
	old do: [ :each |
		self addRemovedPackage: each
		 ]
]

{ #category : #searching }
PDPackageRelationGraphDiff >> lookUpForUndeterminateDependentPackagesFrom: parent [
	| oldDependentPackages undeterminates |
	oldDependentPackages := (oldRelationGraph packageAt: parent packageName) dependentPackages.
	undeterminates := oldDependentPackages reject: [ :package | self removedDependentPackagesIncludes: package from: parent ].
	
	
	undeterminates do: [ :each | self addUndeterminateDependentPackage: each from: parent ].

]

{ #category : #searching }
PDPackageRelationGraphDiff >> lookUpForUndeterminatePackages [
	| undeterminates |
	undeterminates := oldRelationGraph seenPackages reject: [ :package | self removedPackagesIncludes: package ].
	undeterminates do: [ :each | self addUndeterminatePackage: each ]
]

{ #category : #searching }
PDPackageRelationGraphDiff >> make [
	self 
		makePackagesDiff;	
		makeDependentPackagesDiff
		
]

{ #category : #searching }
PDPackageRelationGraphDiff >> makeDependenciesDiff [
]

{ #category : #searching }
PDPackageRelationGraphDiff >> makeDependentPackagesDiff [
	"we're just looking at the package undeterminate"
	"every dependent packages are removed or new in older or new packages"
	self packagesDiffUnderteminate do: [ :item |
			self makeDependentPackagesDiffOn: item content.
		 ]
	
]

{ #category : #searching }
PDPackageRelationGraphDiff >> makeDependentPackagesDiffOn: aPackage [
	
	| oldDependentPackages newDependentPackages  |
	
	oldDependentPackages := (oldRelationGraph packageAt: aPackage packageName) dependentPackages.
	newDependentPackages := (newRelationGraph packageAt: aPackage packageName) dependentPackages.
	
	self lookUpForRemovedDependentPackages: oldDependentPackages with: newDependentPackages from: aPackage.
	self lookUpForNewDependentPackages: newDependentPackages with: oldDependentPackages from: aPackage.
	self lookUpForUndeterminateDependentPackagesFrom: aPackage.
]

{ #category : #searching }
PDPackageRelationGraphDiff >> makePackagesDiff [
	"lookUp for new and remove packages"

	self
		lookUpForRemovedPackages;
		lookUpForNewPackages;
		 lookUpForUndeterminatePackages.
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> newRelationGraph [
	^ newRelationGraph
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> newRelationGraph: anObject [
	newRelationGraph := anObject
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> oldRelationGraph [
	^ oldRelationGraph
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> oldRelationGraph: anObject [
	oldRelationGraph := anObject
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packageDiffNamed: aName [
	^ self packagesDiff detect: [ :item | item content packageName = aName ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiff [
	^ packagesDiff
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiffNew [
	^ packagesDiff select: [ :each | each isNew ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiffNewSize [
	^ self packagesDiffNew size
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiffRemoved [
	^ packagesDiff select: [ :each | each isRemoved ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiffRemovedSize [
	^ self packagesDiffRemoved size
]

{ #category : #'as yet unclassified' }
PDPackageRelationGraphDiff >> packagesDiffToDisplay [
	^ packagesDiff select: [ :each | each canBeDisplay ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiffUnderteminate [
	^ packagesDiff select: [ :each | each isUnderteminate  ]
]

{ #category : #accessing }
PDPackageRelationGraphDiff >> packagesDiffUnderteminateSize [
	^ self packagesDiffUnderteminate size
]

{ #category : #testing }
PDPackageRelationGraphDiff >> removedDependentPackagesIncludes: aPackage from: parent [
	^ self dependentPackagesDiffRemoved
		detect: [ :package | package content = aPackage and: [ package parent = parent ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #testing }
PDPackageRelationGraphDiff >> removedPackagesIncludes: seenPackage [

	^ self packagesDiffRemoved detect: [ :each | each content = seenPackage ]
			ifFound: [ true ]
			ifNone: [ false ]

]
