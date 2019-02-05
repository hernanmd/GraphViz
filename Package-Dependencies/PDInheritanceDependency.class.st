"
A PDInheritanceDependency is an inheritance dependency between two packages.

	superclass:		the superclass that includes in the target PDPackag

"
Class {
	#name : #PDInheritanceDependency,
	#superclass : #PDDependencyFromClass,
	#instVars : [
		'superclass'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #testing }
PDInheritanceDependency >> isInheritanceDependency [
	^ true
]

{ #category : #printing }
PDInheritanceDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: ' inherits from ';
		nextPutAll: self superclass name
]

{ #category : #accessing }
PDInheritanceDependency >> superclass [
	^ superclass
]

{ #category : #accessing }
PDInheritanceDependency >> superclass: aClass [
	superclass := aClass
]
