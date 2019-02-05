"
A PDClassDependencyNode is the superclass node for PDInheritanceNode and PDTraitDependencyNode. 
Indeed these two nodes have the same behavior to browse the dependency in the Nautilus UI.

"
Class {
	#name : #PDClassNode,
	#superclass : #PDNode,
	#category : 'Package-Dependencies-UI-Node'
}

{ #category : #'browse-nautilus' }
PDClassNode >> browseInNautilus [
	self browseClassInNautilus: self classFromContent
]

{ #category : #'browse-nautilus' }
PDClassNode >> classFromContent [
	^ self content theClass
]
