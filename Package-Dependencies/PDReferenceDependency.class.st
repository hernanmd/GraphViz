"
A PDReferenceDependency is a reference dependency between two packages. 

Instance Variables
	reference:		the reference class
	selector:		the selector that references the class
	method : 		the CompiledMethod

"
Class {
	#name : #PDReferenceDependency,
	#superclass : #PDDependencyFromClass,
	#instVars : [
		'selector',
		'reference',
		'method'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #testing }
PDReferenceDependency >> isReferenceDependency [
	^ true
]

{ #category : #accessing }
PDReferenceDependency >> method [
	^ method
]

{ #category : #accessing }
PDReferenceDependency >> method: anObject [
	method := anObject
]

{ #category : #printing }
PDReferenceDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: '>>';
		print: self selector;
		nextPutAll: ' references ';
		print: self reference
]

{ #category : #accessing }
PDReferenceDependency >> reference [
	^ reference
]

{ #category : #accessing }
PDReferenceDependency >> reference: aClass [
	reference := aClass
]

{ #category : #accessing }
PDReferenceDependency >> selector [
	^ selector
]

{ #category : #accessing }
PDReferenceDependency >> selector: aSymbol [
	selector := aSymbol
]
