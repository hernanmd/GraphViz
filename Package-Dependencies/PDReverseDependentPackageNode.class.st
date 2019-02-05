"
A PDReverseDependentPackageNode is used to display a dependent package in a reverse tree.
"
Class {
	#name : #PDReverseDependentPackageNode,
	#superclass : #PDAbstractPackageNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDReverseDependentPackageNode >> childNodeClassFor: anItem [
	^ self nodeForDependency: anItem
]

{ #category : #'as yet unclassified' }
PDReverseDependentPackageNode >> children [
	self isExtensionCheckBoxChecked 
			ifFalse: [ ^ self dependenciesToParentNode dependenciesWithoutExtensionDependency ].
	^ self dependenciesToParentNode dependencies
]

{ #category : #'as yet unclassified' }
PDReverseDependentPackageNode >> dependenciesToParentNode [
	^ self content pdPackage compositeDependencyTo: (self parentNode content pdPackage)
]

{ #category : #'as yet unclassified' }
PDReverseDependentPackageNode >> hasChildren [
	^ self dependenciesToParentNode isNotNil
]

{ #category : #accessing }
PDReverseDependentPackageNode >> icon [
	^ Smalltalk ui icons iconNamed: #backIcon
]
