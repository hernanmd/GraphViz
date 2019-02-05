"
A PDCycleNode is used to display a extension dependency in a tree.
"
Class {
	#name : #PDExtensionDependencyNode,
	#superclass : #PDMethodDependencyNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #accessing }
PDExtensionDependencyNode >> icon [
	^  Smalltalk ui icons iconNamed: #editIcon
]
