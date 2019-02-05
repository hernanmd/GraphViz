"
A PDReversePackageNode is a node to display a package in the tree during a reverse analysis.
"
Class {
	#name : #PDReversePackageNode,
	#superclass : #PDAbstractPackageNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDReversePackageNode >> childNodeClassFor: anItem [
	^ PDReverseDependentPackageNode 
]

{ #category : #'as yet unclassified' }
PDReversePackageNode >> children [
	| child |
	child := self isExtensionCheckBoxChecked
		ifFalse: [ self content usersOfPackageWithoutExtensionDependency ]
		ifTrue: [ self content usersOfPackage ].
	^ (child collect: [ :each | each asPackageDependencyWrapper ]) asSortedCollection
]

{ #category : #'as yet unclassified' }
PDReversePackageNode >> hasChildren [
	^ true
]

{ #category : #'as yet unclassified' }
PDReversePackageNode >> icon [
	^ Smalltalk ui icons iconNamed: #packageIcon
]
