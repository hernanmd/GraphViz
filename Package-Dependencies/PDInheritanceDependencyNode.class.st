"
A PDCycleNode is used to display a inheritance dependency in a tree.
"
Class {
	#name : #PDInheritanceDependencyNode,
	#superclass : #PDClassNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDInheritanceDependencyNode >> browseInOtherNautilus [
	self browseClass: self content superclass
]

{ #category : #accessing }
PDInheritanceDependencyNode >> icon [
	^  Smalltalk ui icons iconNamed: #arrowUpIcon
]

{ #category : #accessing }
PDInheritanceDependencyNode >> isClassToDependencyNode [
	^ true
]
