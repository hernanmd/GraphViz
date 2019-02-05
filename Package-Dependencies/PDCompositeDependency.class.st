"
A PDCompositeDependency is a composite dependency. A composite pattern is using.

Actually in all case this dependency contains the dependencies between two packages and the instance variable dependencies contains all the type of dependencies (Extension, Inheritance, Reference, Trait).
"
Class {
	#name : #PDCompositeDependency,
	#superclass : #PDPackageDependency,
	#instVars : [
		'dependencies'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #adding }
PDCompositeDependency >> add: aDependency [
	dependencies add: aDependency
]

{ #category : #testing }
PDCompositeDependency >> containsOnlyExtensionDependency [
	(self dependencies isEmpty ) ifTrue: [ ^ false ].
	 ^ self dependencies allSatisfy: [ :dependency | dependency isExtensionDependency ]
]

{ #category : #accessing }
PDCompositeDependency >> dependencies [
	^ dependencies
]

{ #category : #accessing }
PDCompositeDependency >> dependenciesFrom: aClass [
	
	^ dependencies select: [ :reference | reference theClass = aClass ].
]

{ #category : #testing }
PDCompositeDependency >> dependenciesWithoutExtensionDependency [
	^ dependencies reject: [ :dependency | dependency isExtensionDependency ].
]

{ #category : #accessing }
PDCompositeDependency >> extensionDependencies [
 	^ dependencies select: [ :each | each isExtensionDependency ]
]

{ #category : #accessing }
PDCompositeDependency >> extensionDependenciesSize [
	^ self dependencies
		detectSum: [ :dependency | 
			dependency isExtensionDependency
				ifTrue: [ 1 ]
				ifFalse: [ 0 ] ]
]

{ #category : #initialization }
PDCompositeDependency >> initializeFrom: aSourcePackage to: aTargetPackage [

	super initializeFrom: aSourcePackage to: aTargetPackage.
	dependencies := OrderedCollection new
]

{ #category : #'as yet unclassified' }
PDCompositeDependency >> mySize [
	^ dependencies size
]

{ #category : #printing }
PDCompositeDependency >> printReasonOn: aStream [
	aStream nextPutAll: dependencies size asString; nextPutAll: ' dependencies: '.
	dependencies
		do: [ :each | each printReasonOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #printing }
PDCompositeDependency >> printShortReasonOn: aStream [
	aStream nextPutAll: dependencies size asString
]

{ #category : #accessing }
PDCompositeDependency >> referenceDependencies [
 	^ dependencies select: [ :each | each isReferenceDependency ]
]

{ #category : #accessing }
PDCompositeDependency >> referenceDependenciesFrom: aClass [
	| references |
	references := self referenceDependencies.
	
	^ references select: [ :reference | reference theClass = aClass ].
]
