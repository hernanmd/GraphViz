"
Other wrapper for dependent package (use in TreeModel). Useful in reverse analysis.
"
Class {
	#name : #PDDependentPackageWrapper,
	#superclass : #Object,
	#instVars : [
		'pdPackage',
		'relationGraph'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDDependentPackageWrapper class >> newWith: aPackage on: relationGraph [
	^ self new initializeFrom: aPackage on: relationGraph
]

{ #category : #comparing }
PDDependentPackageWrapper >> <= other [
	^ self pdPackage <= other pdPackage
]

{ #category : #accessing }
PDDependentPackageWrapper >> dependenciesSize [
	| usersOf |
	usersOf := self usersOfPackage.
	^ usersOf
			 inject: 0
			 into: [ :sum :each | sum + (each dependenciesSizeTo: self pdPackage) ]
]

{ #category : #accessing }
PDDependentPackageWrapper >> extensionDependenciesSize [
	| usersOf |
	usersOf := self usersOfPackage.
	^ usersOf 
			inject: 0 
			into: [ :sum :each | sum + (each extensionDependenciesSizeTo: self pdPackage) ]
]

{ #category : #initialization }
PDDependentPackageWrapper >> initializeFrom: aPackage on: aRelationGraph [
	pdPackage := aPackage.
	relationGraph :=aRelationGraph.
]

{ #category : #accessing }
PDDependentPackageWrapper >> packageName [
	^ self pdPackage packageName
]

{ #category : #accessing }
PDDependentPackageWrapper >> pdPackage [
	^ pdPackage
]

{ #category : #accessing }
PDDependentPackageWrapper >> pdPackage: anObject [
	pdPackage := anObject
]

{ #category : #printing }
PDDependentPackageWrapper >> printOn: aStream [
	| numberOfExtension |
	numberOfExtension := self extensionDependenciesSize.
	aStream
		nextPutAll: self packageName;
		nextPutAll: ' <-- Users : ';
		nextPutAll: self usersOfPackageSize asString;
		nextPutAll: ' package(s) | ';
		nextPutAll: 'Dependencies : ';
		nextPutAll: ((self dependenciesSize) - numberOfExtension) asString;
		nextPutAll: ' (+ ';
		nextPutAll: numberOfExtension asString;
		nextPutAll: ' extension dependencies ';
		nextPutAll: ')'.
]

{ #category : #accessing }
PDDependentPackageWrapper >> rPackageSet [
	^ pdPackage rPackageSet
]

{ #category : #accessing }
PDDependentPackageWrapper >> relationGraph [
	^ relationGraph
]

{ #category : #accessing }
PDDependentPackageWrapper >> relationGraph: anObject [
	relationGraph := anObject
]

{ #category : #accessing }
PDDependentPackageWrapper >> usersOfPackage [
	^ relationGraph usersOf: pdPackage
]

{ #category : #accessing }
PDDependentPackageWrapper >> usersOfPackageSize [
	^ self usersOfPackage size
]

{ #category : #accessing }
PDDependentPackageWrapper >> usersOfPackageWithoutExtensionDependency [
	^ relationGraph usersOfWithoutExtensionDependency: pdPackage
]
