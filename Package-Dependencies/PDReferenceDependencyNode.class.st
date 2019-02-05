"
A PDCycleNode is used to display a reference dependency in a tree.
"
Class {
	#name : #PDReferenceDependencyNode,
	#superclass : #PDMethodDependencyNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDReferenceDependencyNode >> browseInOtherNautilus [
	| classToBrowse |
	classToBrowse := self content reference.
	self browseClass: classToBrowse
]

{ #category : #testing }
PDReferenceDependencyNode >> browseSendersOrUsers [
	
]

{ #category : #accessing }
PDReferenceDependencyNode >> icon [
	^  Smalltalk ui icons iconNamed: #classIcon
]

{ #category : #testing }
PDReferenceDependencyNode >> isClassToDependencyNode [
	^ true
]

{ #category : #testing }
PDReferenceDependencyNode >> isReferenceNode [
	  ^ true
]
