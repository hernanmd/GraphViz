"
A PDMethodNode is the superclass node for PDReferenceDependencyNode and PDExtensionDependencyNode. 
Indeed these two nodes have the same behavior to browse the dependency in the Nautilus UI.

"
Class {
	#name : #PDMethodDependencyNode,
	#superclass : #PDNode,
	#category : 'Package-Dependencies-UI-Node'
}

{ #category : #'browse-nautilus' }
PDMethodDependencyNode >> browseInNautilus [
	| methodToBrowse |
	methodToBrowse := self content method.
	"Nautilus have a problem to refresh, repeat 2 times the operation"
	2 timesRepeat: [ self browseMethodInNautilus: methodToBrowse ].
]
