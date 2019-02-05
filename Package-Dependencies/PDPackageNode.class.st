"
A PDPackageNode is used to display a package in a tree.
"
Class {
	#name : #PDPackageNode,
	#superclass : #PDAbstractPackageNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #procotol }
PDPackageNode >> childNodeClassFor: anItem [
	^ PDDependentPackageNode
]

{ #category : #accessing }
PDPackageNode >> children [
	| child |
	child := self rootNode isCycle
		ifTrue: [ self rootNode content dependentPackagesFrom: self content ]
		ifFalse: [ 
			self isExtensionCheckBoxChecked
				ifFalse: [ self content dependentPackagesWithoutExtensionDependency ]
				ifTrue: [ self content dependentPackages ] ].
	^ (child collect: [ :package | package asPackageDependencyWrapper ]) asSortedCollection
]

{ #category : #accessing }
PDPackageNode >> hasChildren [
	^ self content dependentPackages isNotEmpty
]

{ #category : #accessing }
PDPackageNode >> icon [
	^ Smalltalk ui icons iconNamed: #packageIcon
]

{ #category : #testing }
PDPackageNode >> isPackageNode [
	^ true
]
