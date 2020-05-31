"
I'm a package dependency graph. 
To build the dependency graph among packages, you have just to give a set of PDPackage on entry. Then :

	- use the message computeStaticDependencies messages to retrieve all the dependency among the packages.
	- use the message removeInternalDependencies if you want to remove all the internal dependency.
	- finally use combineDependencies to combine each dependency which have the same source and the target into 	composite dependency.
		
"
Class {
	#name : #PDPackageRelationGraph,
	#superclass : #Object,
	#instVars : [
		'packages',
		'classToPackage'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDPackageRelationGraph class >> new [
	^ self onPackages: OrderedCollection new
]

{ #category : #'instance creation' }
PDPackageRelationGraph class >> onPackages: aCollection [
	^ self basicNew initializeWithPackages: aCollection; yourself
]

{ #category : #adding }
PDPackageRelationGraph >> addExtensionDependencies: aPDPackage [
	| sourcePackage |
	
	aPDPackage rPackageSet extensionMethods
		do: [ :method | 
			sourcePackage := self packageForBehavior: method actualClass.
			self addPackage: sourcePackage.
			sourcePackage
				add:
					((PDExtensionDependency from: sourcePackage to: aPDPackage)
						theClass: method actualClass;
						selector: method selector asSymbol;
						method: method).
			 ]
]

{ #category : #adding }
PDPackageRelationGraph >> addInheritanceDependencies: aPackage [
	| package |
	self package: aPackage
		classesDo: [ :class | 
			class superclass ifNotNil: [ 
					package := self packageForBehavior: class superclass.
					aPackage
						add:
							((PDInheritanceDependency from: aPackage to: package)
								theClass: class;
								superclass: class superclass).
					self addPackage: package ] ]
]

{ #category : #adding }
PDPackageRelationGraph >> addPackage: aPDPackage [
	aPDPackage beIncluded.
	packages at: aPDPackage packageName put: aPDPackage
]

{ #category : #adding }
PDPackageRelationGraph >> addPackages: aCollection [
	aCollection
		do: [ :package | 
			self addPackage: package ]
]

{ #category : #adding }
PDPackageRelationGraph >> addReferenceDependencies: aPackage [
	(self methodsFor: aPackage) do: [ :method | self findReferencesIn: method for: aPackage ]
]

{ #category : #adding }
PDPackageRelationGraph >> addTraitDependencies: aPackage [
	| package |
	self package: aPackage
		classesDo: [ :class | 
			class traits
				do: [ :trait |
					package := self packageForBehavior: trait.
					aPackage
						add:
							((PDTraitDependency from: aPackage to: package)
								theClass: class;
								trait: trait).
					self addPackage: package ] ]
]

{ #category : #accessing }
PDPackageRelationGraph >> allDependentPackagesFromSeenPackages [
	| aSet |
	aSet := Set new.
	self seenPackages do: [ :seenPackage |
		aSet addAll: (seenPackage dependentPackages) ].
	
	^ aSet	

]

{ #category : #accessing }
PDPackageRelationGraph >> allDependentPackagesFromSeenPackagesWithoutExtensionDependency [
	| aSet |
	aSet := Set new.
	self seenPackages do: [ :seenPackage |
		aSet addAll: (seenPackage dependentPackagesWithoutExtensionDependency ) ].
	
	^ aSet	

]

{ #category : #'as yet unclassified' }
PDPackageRelationGraph >> allExtensionDependencies [
	| aCollectionOfExtensionDependency |
	aCollectionOfExtensionDependency := OrderedCollection new.
	
	self seenPackages do: [ :each |
		each dependencies do: [ :dependency |
			aCollectionOfExtensionDependency addAll: dependency extensionDependencies.
			 ]
		 ].
	^ aCollectionOfExtensionDependency
]

{ #category : #'as yet unclassified' }
PDPackageRelationGraph >> allReferenceDependencies [
	| aCollectionOfReferenceDependency |
	aCollectionOfReferenceDependency := OrderedCollection new.
	
	self seenPackages do: [ :each |
		each dependencies do: [ :dependency |
			aCollectionOfReferenceDependency addAll: dependency referenceDependencies.
			 ]
		 ].
	^ aCollectionOfReferenceDependency
]

{ #category : #testing }
PDPackageRelationGraph >> allSeen [
	
	^ self packages allSatisfy: [ :each | each isSeen ].
]

{ #category : #building }
PDPackageRelationGraph >> build [
	"build the dependency graph"
	self 
		computeStaticDependencies;
		removeInternalDependencies;
		combineDependencies
]

{ #category : #accessing }
PDPackageRelationGraph >> classToPackage [
	^ classToPackage
]

{ #category : #accessing }
PDPackageRelationGraph >> classToPackage: aClass [
	^ (classToPackage at: aClass) packageName
]

{ #category : #adding }
PDPackageRelationGraph >> classesFor: aPackage [
	^ aPackage rPackageSet classes
]

{ #category : #actions }
PDPackageRelationGraph >> clearAllDependencies [
	packages do: [ :package | package clearDependencies ]
]

{ #category : #updating }
PDPackageRelationGraph >> clearPackages [
	packages := Dictionary new
]

{ #category : #actions }
PDPackageRelationGraph >> combineDependencies [
	"Combine all dependencies with the same source and target into one composite
	dependency."
	self packages 
		do: [ :each | self combineDependencies: each ]
		displayingProgress: 'Combining Dependencies'
]

{ #category : #private }
PDPackageRelationGraph >> combineDependencies: aPackage [
	| grouped composite |
	
	grouped := aPackage dependencies
		groupedBy: [ :each | each target ]
		having: [ :each | true ].
	aPackage clearDependencies.
	
	grouped keysAndValuesDo: [ :target :dependencies |
		composite := PDCompositeDependency from: aPackage to: target.
		dependencies do: [ :each | composite add: each ].
		aPackage add: composite ]
]

{ #category : #adding }
PDPackageRelationGraph >> computeStaticDependencies [
	self packages
		do: [ :each | 
			each isSeen
				ifFalse: [ 
					self computeStaticDependencies: each.
					each beSeen ] ]  
		displayingProgress: 'Analyzing Packages'
]

{ #category : #adding }
PDPackageRelationGraph >> computeStaticDependencies: aPackage [
	
	self addInheritanceDependencies: aPackage.
	self addExtensionDependencies: aPackage.
	self addReferenceDependencies: aPackage.
	self addTraitDependencies: aPackage.
]

{ #category : #accessing }
PDPackageRelationGraph >> dependenciesFrom: aPackage [
	"Answer all seen packages."

	^ (packages at: aPackage) dependencies
]

{ #category : #adding }
PDPackageRelationGraph >> findReferencesIn: aMethod for: aPackage [
	| package |

	aMethod compiledMethod ifNotNil: [ : compiledMethod | 
		compiledMethod literals ifNotEmpty: [ : cmLiterals | 
			cmLiterals allButLast do: [ :literal | 
				(self isReference: literal)
					ifTrue: [ 
						package := self packageForBehavior: literal value.
						self addPackage: package.
						aPackage
							add:
								((PDReferenceDependency from: aPackage to: package)
									theClass: aMethod actualClass;
									selector: aMethod method selector asSymbol;
									reference: literal value;
									method: aMethod;
									yourself) ] ] ] ]
]

{ #category : #accessing }
PDPackageRelationGraph >> includedPackages [
	"Answer the currently analyzed set of packages."

	^ self packages select: [ :each | each isIncluded ]
]

{ #category : #accessing }
PDPackageRelationGraph >> includesSeenPackage: aPackage [	
	^ self seenPackages includes: aPackage
]

{ #category : #initialization }
PDPackageRelationGraph >> initializeWithPackages: aCollection [
	self initialize.
	packages := Dictionary new.
	aCollection do: [ :each | self addPackage: each ].
	classToPackage := IdentityDictionary new
]

{ #category : #testing }
PDPackageRelationGraph >> isReference: aLiteral [
	^ aLiteral isVariableBinding and: [ aLiteral value isBehavior and: [ aLiteral key = aLiteral value name ] ]
]

{ #category : #adding }
PDPackageRelationGraph >> methodsFor: aPackage [
	^ aPackage rPackageSet methods
]

{ #category : #accessing }
PDPackageRelationGraph >> outgoing [
	"Answer a collection of all dependencies that point out of the current package set."

	^ self includedPackages
		inject: Bag new
		into: [ :outgoing :package |
			package dependencies do: [ :each |
				(each isInternal or: [ each target isIncluded ])
					ifFalse: [ outgoing add: each ] ].
			outgoing ]
]

{ #category : #updating }
PDPackageRelationGraph >> pDPackagewith: packageName [
	^ PDPackage on: (RPackageSet named: packageName)
]

{ #category : #enumerating }
PDPackageRelationGraph >> package: aPackage classesDo: aBlock [ 
	aPackage rPackageSet classes do: aBlock
]

{ #category : #accessing }
PDPackageRelationGraph >> packageAt: aPackageName [
	"answer a PDPackage"
	(packages keys includes: aPackageName) ifTrue: [  
	^ packages at: aPackageName ].
	^ nil
]

{ #category : #queries }
PDPackageRelationGraph >> packageForBehavior: aClass [
	"return a PDPackage and put in classToPackage"

	^ classToPackage
		at: aClass
		ifAbsentPut: [ 
			self packages
				detect: [ :each | each rPackageSet includesClass: aClass ]
				ifNone: [ self systemPackageContaining: aClass ] ]
]

{ #category : #accessing }
PDPackageRelationGraph >> packageNamed: aString ifAbsent: aBlock [
	^ packages at: aString ifAbsent: aBlock
]

{ #category : #accessing }
PDPackageRelationGraph >> packages [

	^ packages values
]

{ #category : #accessing }
PDPackageRelationGraph >> packagesName [

	^ packages keys
]

{ #category : #accessing }
PDPackageRelationGraph >> pdPackageFrom: aClass [
	^ packages detect: [ :package | package rPackageSet includesClass: aClass ]
]

{ #category : #accessing }
PDPackageRelationGraph >> predecessors: aPackage [
	"returns a Collection with the predecessors of the package"

	| aCollection |
	aCollection := OrderedCollection new.
	self packages
		do: [ :package | 
			package dependencies
				do: [ :dependency | 
					dependency target = aPackage
						ifTrue: [ aCollection add: package ] ] ].
	^ aCollection
]

{ #category : #updating }
PDPackageRelationGraph >> refreshGraph [
	| olderPackages refreshPackage |
	classToPackage := IdentityDictionary new.
	olderPackages := self seenPackagesName.
	self clearPackages.
	olderPackages
		do: [ :packageName | 
			refreshPackage := self pDPackagewith: packageName.
			self addPackage: refreshPackage ].
	self build
]

{ #category : #updating }
PDPackageRelationGraph >> refreshPackageDependencies: aPackage [
	aPackage clearDependencies.
	self computeStaticDependencies: aPackage.
	self combineDependencies: aPackage.
	aPackage removeAllInternal.
	aPackage beSeen.
	
]

{ #category : #actions }
PDPackageRelationGraph >> removeInternalDependencies [
	"Remove all dependencies from a package to itself"
	
	self includedPackages
		do: [ :each | each removeAllInternal ]
		displayingProgress: 'Removing internal Dependencies'
]

{ #category : #actions }
PDPackageRelationGraph >> removeOutgoingDependencies [
	"Remove all dependencies to packages not included in this relation"
	
	self includedPackages
		do: [ :each | self removeOutgoingDependencies: each ]
		displayingProgress: 'Removing outgoing Dependencies'
]

{ #category : #private }
PDPackageRelationGraph >> removeOutgoingDependencies: aPackage [
	| removals |
	removals := aPackage dependencies reject: [ :each | each target isIncluded ].
	removals do: [ :each | aPackage remove: each ]
]

{ #category : #removing }
PDPackageRelationGraph >> removePackage: packageName [
	^ packages removeKey: packageName
]

{ #category : #actions }
PDPackageRelationGraph >> seenPackages [
	^ self packages 
		select: [ :each | each isSeen ]
]

{ #category : #accessing }
PDPackageRelationGraph >> seenPackagesName [
	"Answer all seen packages name."

	^ self seenPackages collect: [ :package | package packageName ]
]

{ #category : #actions }
PDPackageRelationGraph >> seenPackagesWithFilter: aFilter [
	^ self packages 
		select: [ :each | each isSeen and: [ aFilter match: each packageName ] ].
]

{ #category : #actions }
PDPackageRelationGraph >> seenPackagesWithoutExtension [
	^ self packages select: [ :each | each isSeen ]
]

{ #category : #accessing }
PDPackageRelationGraph >> successors: aPackage [
	"answer a collection with the successors of aPackage in the graph"

	| aCollection |
	aCollection := OrderedCollection new.
	(packages at: aPackage packageName) dependencies
		do: [ :dependency | 
			(self packagesName includes: dependency target packageName)
				ifTrue: [ aCollection add: dependency target ] ].
	^ aCollection
]

{ #category : #queries }
PDPackageRelationGraph >> systemPackageContaining: aClass [
	| info |
	info := (RPackageOrganizer default packageOf: aClass) packageName.
	^ info
		ifNil: [ self error: 'Package for ' , aClass name , ' not found.' ]
		ifNotNil: [ PDPackage on: (RPackageSet named: info asString) ]
]

{ #category : #'as yet unclassified' }
PDPackageRelationGraph >> usersOf: aPackage [
	| users |
	users := OrderedCollection new.
	self seenPackages
		do: [ :package | 
			(package dependentPackages includes: aPackage)
				ifTrue: [ users add: package ] ].
	^ users
]

{ #category : #'as yet unclassified' }
PDPackageRelationGraph >> usersOfWithoutExtensionDependency: aPackage [
	| users |
	users := OrderedCollection new.
	self seenPackages do: [ :package |
			(package dependentPackagesWithoutExtensionDependency includes: aPackage) ifTrue: [ 
				users add: package.
				 ]
		].
	^ users.
]
