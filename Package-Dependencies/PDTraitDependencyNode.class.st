"
A PDCycleNode is used to display a trait dependency in a tree.
"
Class {
	#name : #PDTraitDependencyNode,
	#superclass : #PDClassNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDTraitDependencyNode >> browseInOtherNautilus [
	self browseClass: self content trait
]

{ #category : #accessing }
PDTraitDependencyNode >> icon [
	^  Smalltalk ui icons iconNamed: #traitIcon
]
