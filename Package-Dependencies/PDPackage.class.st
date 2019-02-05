"
I am a PDPackage and i represent a package (RPackageSet) and all his dependencies (PDPackageDependency).

Instance variables :

	- dependencies : a collection of PDPackageDependency (actually the nodes of a graph dependency, from a source PDPackage to a target PDPackage)
	- included : says if the PDPackage is included or not in the set of packages at the beginning.
	- rpackage : the instance of asRPackageSet 	
	- inStack : useful for tarjan algorithm and cycle algorithm. It avoid stack access
	- tarjanIndex and tarjanLowLink : integer for the tarjan algorithm.
	- bfsParent : see cycle algorithm
	- seen : says if all dependencies have been added to the Package
"
Class {
	#name : #PDPackage,
	#superclass : #Object,
	#instVars : [
		'dependencies',
		'included',
		'inStack',
		'tarjanIndex',
		'tarjanLowLink',
		'bfsParent',
		'seen',
		'rPackageSet'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDPackage class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
PDPackage class >> on: aRPackageSet [
	^ self basicNew initializeWithPackage: aRPackageSet; yourself
]

{ #category : #comparing }
PDPackage >> <= aPackage [
	^ (self packageName asString) <= (aPackage packageName asString)
]

{ #category : #comparing }
PDPackage >> = aPackage [
	(aPackage isKindOf: PDPackage)
		ifFalse: [ ^ false ].
	^ self packageName = aPackage packageName
]

{ #category : #adding }
PDPackage >> add: aDependency [
	^ dependencies add: aDependency
]

{ #category : #converting }
PDPackage >> asDependentPackageWrapperOn: relationGraph [
	^ PDDependentPackageWrapper newWith: self on: relationGraph
]

{ #category : #converting }
PDPackage >> asPackageDependencyWrapper [
	^ PDPackageDependencyWrapper newWith: self.
]

{ #category : #accessing }
PDPackage >> beIncluded [
	included := true
]

{ #category : #accessing }
PDPackage >> beSeen [
	seen := true
]

{ #category : #accessing }
PDPackage >> bfsParent [
	^ bfsParent
]

{ #category : #accessing }
PDPackage >> bfsParent: aBfsParent [
	bfsParent := aBfsParent
]

{ #category : #initialization }
PDPackage >> clearDependencies [
	dependencies := OrderedCollection new
]

{ #category : #dependencies }
PDPackage >> compositeDependencyTo: aPackage [
	^ self dependencies detect: [ :dependency | dependency target = aPackage ] ifNone: [ nil ]
]

{ #category : #accessing }
PDPackage >> dependencies [
	^ dependencies
]

{ #category : #accessing }
PDPackage >> dependencies: anObject [
	dependencies := anObject
]

{ #category : #accessing }
PDPackage >> dependenciesFrom: aClass [
	| dependenciesFrom |
	dependenciesFrom := OrderedCollection new.
	self dependencies
		do: [ :compositeDependency | 
				dependenciesFrom addAll: (compositeDependency dependenciesFrom: aClass) ].
	^ dependenciesFrom
]

{ #category : #accessing }
PDPackage >> dependenciesSize [

	^ self dependencies 
			inject: 0
			into: [ :sum :dependency |
					sum + dependency mySize
				]
]

{ #category : #dependencies }
PDPackage >> dependenciesSizeTo: aPackage [
	| dependency |
	dependency := dependencies detect: [ :each | each target packageName = aPackage packageName ].
	^ dependency ifNotNil: [ dependency mySize ] ifNil: [ 0 ]
]

{ #category : #dependencies }
PDPackage >> dependenciesTo: aPackage [
	^ dependencies select: [ :each | each target packageName = aPackage ].
]

{ #category : #dependencies }
PDPackage >> dependentPackages [
	^ self dependencies 
			inject: Set new 
			into: [ :sum :each | sum add: each target; yourself ].
]

{ #category : #dependencies }
PDPackage >> dependentPackagesSize [
	^ dependencies size
]

{ #category : #dependencies }
PDPackage >> dependentPackagesWithoutExtensionDependency [
	^ self dependencies
		inject: Set new
		into: [ :sum :each | 
			each containsOnlyExtensionDependency
				ifFalse: [ 
					sum
						add: each target;
						yourself ]
				ifTrue: [ sum ] ]
]

{ #category : #accessing }
PDPackage >> extensionDependenciesSize [
	^ self dependencies
		inject: 0
		into: [ :sum :each | sum + each extensionDependenciesSize ]
]

{ #category : #dependencies }
PDPackage >> extensionDependenciesSizeTo: aPackage [
	^ (self compositeDependencyTo: aPackage) extensionDependenciesSize 
]

{ #category : #comparing }
PDPackage >> hash [
	^ self packageName hash
]

{ #category : #accessing }
PDPackage >> inStack: aBoolean [
	inStack := aBoolean
]

{ #category : #accessing }
PDPackage >> included: anObject [
	included := anObject
]

{ #category : #initialization }
PDPackage >> initializeWithPackage: aRPackageSet [
	self initialize.
	self clearDependencies.
	rPackageSet := aRPackageSet.
	included := false.
	inStack := false.
	seen := false.
	tarjanIndex := -1.
	tarjanLowLink := -1.

]

{ #category : #testing }
PDPackage >> isInStack [
	^ inStack
]

{ #category : #testing }
PDPackage >> isIncluded [
	^ included
]

{ #category : #testing }
PDPackage >> isSeen [

	^ seen
]

{ #category : #tarjan }
PDPackage >> isTarjanUndefined [
	^ tarjanIndex = -1
]

{ #category : #accessing }
PDPackage >> packageName [
	^ self rPackageSet packageName
]

{ #category : #printing }
PDPackage >> printOn: aStream [
	| numberOfExtension |
	numberOfExtension := self extensionDependenciesSize.
	aStream
		nextPutAll: self packageName;
		nextPutAll: ' --> Dependent packages : ';
		nextPutAll: self dependentPackagesSize asString;
		nextPutAll: ' | Dependencies : ';
		nextPutAll: (self dependenciesSize - numberOfExtension) asString;
		nextPutAll: ' (+ ';
		nextPutAll: numberOfExtension asString;
		nextPutAll: ' extension dependencies)'
]

{ #category : #accessing }
PDPackage >> rPackageSet [
	^ rPackageSet
]

{ #category : #accessing }
PDPackage >> rPackageSet: anObject [
	rPackageSet := anObject
]

{ #category : #accessing }
PDPackage >> referenceDependenciesFrom: aClass [

	^ (self dependenciesFrom: aClass) select: [ :each | each isReferenceDependency ]
]

{ #category : #removing }
PDPackage >> remove: aDependency [
	^ dependencies remove: aDependency
]

{ #category : #dependencies }
PDPackage >> removeAllInternal [
	dependencies := dependencies reject: [ :each | each isInternal ]
]

{ #category : #tarjan }
PDPackage >> tarjanIndex [
	^ tarjanIndex 
]

{ #category : #tarjan }
PDPackage >> tarjanIndex: aTarjanIndex [
	tarjanIndex := aTarjanIndex
]

{ #category : #tarjan }
PDPackage >> tarjanLowLink [
	^ tarjanLowLink
]

{ #category : #tarjan }
PDPackage >> tarjanLowLink: aTarjanLowLink [
	tarjanLowLink := aTarjanLowLink.
]
