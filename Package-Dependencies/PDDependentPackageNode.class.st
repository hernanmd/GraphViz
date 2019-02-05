"
A PDDependentPackageNode is used to display a dependent package in a tree.
"
Class {
	#name : #PDDependentPackageNode,
	#superclass : #PDAbstractPackageNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #procotol }
PDDependentPackageNode >> childNodeClassFor: anItem [
	^ self nodeForDependency: anItem
]

{ #category : #accessing }
PDDependentPackageNode >> children [
	| aCompositeDependency |
	aCompositeDependency := self compositeDependencyTo.
	self isExtensionCheckBoxChecked 
	ifFalse: [ ^ aCompositeDependency dependenciesWithoutExtensionDependency ].
	^ aCompositeDependency dependencies
]

{ #category : #accessing }
PDDependentPackageNode >> compositeDependencyTo [
	"should return one composite dependency anytime"
	^ self parentNode content compositeDependencyTo: self content pdPackage
]

{ #category : #accessing }
PDDependentPackageNode >> hasChildren [
	^  self compositeDependencyTo isNotNil
]

{ #category : #accessing }
PDDependentPackageNode >> icon [
	^ Smalltalk ui icons iconNamed: #forwardIcon
]

{ #category : #'as yet unclassified' }
PDDependentPackageNode >> isPackageNode [
	^ true
]
