"
A PDTraitDependency is a trait dependency between two packages. 


Instance Variable
	trait:		the trait
"
Class {
	#name : #PDTraitDependency,
	#superclass : #PDDependencyFromClass,
	#instVars : [
		'trait'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #testing }
PDTraitDependency >> isTraitDependency [
	^ true
]

{ #category : #printing }
PDTraitDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: ' uses ';
		print: self trait name
]

{ #category : #accessing }
PDTraitDependency >> trait [
	^ trait
]

{ #category : #accessing }
PDTraitDependency >> trait: aTrait [
	trait := aTrait
]
