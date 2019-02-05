"
A PDClassToReferenceNode is a node tu display all references dependency from aClass.
We store the package and the name of the class. In all cases, this node will be a root node in a Tree.

"
Class {
	#name : #PDClassToDependencyNode,
	#superclass : #PDClassNode,
	#instVars : [
		'package'
	],
	#category : 'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDClassToDependencyNode >> browseInOtherNautilus [
	self browseClass: self content browse
]

{ #category : #procotol }
PDClassToDependencyNode >> childNodeClassFor: anItem [
	 ^ self nodeForDependency: anItem
]

{ #category : #accessing }
PDClassToDependencyNode >> children [
	^ self dependencies
]

{ #category : #accessing }
PDClassToDependencyNode >> dependencies [
	^ self package dependenciesFrom: self content
]

{ #category : #accessing }
PDClassToDependencyNode >> hasChildren [
	^ self dependencies isNotEmpty
]

{ #category : #accessing }
PDClassToDependencyNode >> icon [
	^ Smalltalk ui icons iconNamed: #confirmIcon
]

{ #category : #accessing }
PDClassToDependencyNode >> package [
	^ package
]

{ #category : #accessing }
PDClassToDependencyNode >> package: anObject [
	package := anObject
]
