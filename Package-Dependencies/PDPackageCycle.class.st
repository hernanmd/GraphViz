"
A PDPackageCycle is used to represent a cycle among packages. 	
All the packages in the cycle are stored in a Collection, in the their name alphabetical order.

As soon as possible, they will be stored in the order they have been found.
"
Class {
	#name : #PDPackageCycle,
	#superclass : #Object,
	#instVars : [
		'packages'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDPackageCycle class >> new [
	^ self basicNew initialize; yourself.
]

{ #category : #comparing }
PDPackageCycle >> <= aPDPackageCycle [
	^ (self size) <= (aPDPackageCycle size)

]

{ #category : #comparing }
PDPackageCycle >> = aPDPackageCycle [
	(aPDPackageCycle isKindOf: PDPackageCycle) ifFalse: [ ^ false ]. 
	^ self size = aPDPackageCycle size and: [ self packages includesAll: aPDPackageCycle packages ].
]

{ #category : #comparing }
PDPackageCycle >> > aPDPackageCycle [
	^ (self size) > (aPDPackageCycle size)

]

{ #category : #adding }
PDPackageCycle >> addAllPackages: aCollection [
	
	aCollection do: [ :package | self addPackage: package].
]

{ #category : #adding }
PDPackageCycle >> addPackage: aPDPackage [
	packages add: aPDPackage
]

{ #category : #accessing }
PDPackageCycle >> dependentPackagesFrom: aPackage [
	"only the dependent packages from the cycle"
	^ aPackage dependentPackages select: [ :package |
		self packages includes: package
		 ]
]

{ #category : #testing }
PDPackageCycle >> hasOutgoingDependencies: aPackage [
	^ aPackage dependencies anySatisfy: [ :dependency | (self packages includes: (dependency target)) not ].
]

{ #category : #initialization }
PDPackageCycle >> initialize [
	super initialize.
	packages := OrderedCollection new.
]

{ #category : #testing }
PDPackageCycle >> isAtLeastInCycle: aCollectionOfPDPackage [
	^ aCollectionOfPDPackage anySatisfy: [ :package | self isInCycle: package ]
]

{ #category : #testing }
PDPackageCycle >> isInCycle: aPackage [
	^ packages includes: aPackage
]

{ #category : #accessing }
PDPackageCycle >> packageAt: anInteger [
	^ packages at: anInteger
]

{ #category : #accessing }
PDPackageCycle >> packages [
	^ packages
]

{ #category : #accessing }
PDPackageCycle >> packages: anObject [
	packages := anObject
]

{ #category : #printing }
PDPackageCycle >> printOn: aStream [
	aStream
		nextPutAll: 'A cycle of ';
		print: self size;
		nextPutAll: ' packages : '.
	packages
		do: [ :package | aStream nextPutAll: package packageName ]
		separatedBy: [ aStream space ]
]

{ #category : #actions }
PDPackageCycle >> removeOutgoingDependencies [
	self packages do: [ :package | self removeOutgoingDependencies: package ].
]

{ #category : #private }
PDPackageCycle >> removeOutgoingDependencies: aPackage [
	
	| removals |
	packages := packages copy.
	removals := aPackage dependencies reject: [ :dependency | self packages includes: (dependency target) ].
	
	removals do: [ :each | aPackage remove: each ].
]

{ #category : #accessing }
PDPackageCycle >> reversedCycle [
	packages := packages reversed
]

{ #category : #accessing }
PDPackageCycle >> size [
	^ packages size
]
