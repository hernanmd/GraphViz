"
A PDExtensionDependency is an extension dependency between two packages.

Instance Variables
	selector:		the selector 
	method : 		the CompiledMethod
		
"
Class {
	#name : #PDExtensionDependency,
	#superclass : #PDDependencyFromClass,
	#instVars : [
		'selector',
		'method'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #testing }
PDExtensionDependency >> isExtensionDependency [
	^ true
]

{ #category : #accessing }
PDExtensionDependency >> method [
	^ method
]

{ #category : #accessing }
PDExtensionDependency >> method: anObject [
	method := anObject
]

{ #category : #printing }
PDExtensionDependency >> printReasonOn: aStream [
	aStream
		nextPutAll: self theClass name;
		nextPutAll: '>>';
		print: self selector;
		nextPutAll: ' (extension)'
]

{ #category : #accessing }
PDExtensionDependency >> selector [
	^ selector
]

{ #category : #accessing }
PDExtensionDependency >> selector: aSelector [
	selector := aSelector
]
