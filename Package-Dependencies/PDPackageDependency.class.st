"
A PDPackageDependency is a dependency between two packages.

	source:		the source PDPackage 
	target:	      the target PDPackage

"
Class {
	#name : #PDPackageDependency,
	#superclass : #Object,
	#instVars : [
		'source',
		'target'
	],
	#category : 'Package-Dependencies-Core'
}

{ #category : #'instance-creation' }
PDPackageDependency class >> from: aSourcePackage to: aDestinationPackage [
	^ self new initializeFrom: aSourcePackage to: aDestinationPackage
]

{ #category : #accessing }
PDPackageDependency >> hash [
	^ source hash bitXor: target hash
]

{ #category : #initialization }
PDPackageDependency >> initializeFrom: aSourcePackage to: aTargetPackage [
	source := aSourcePackage.
	target := aTargetPackage
]

{ #category : #testing }
PDPackageDependency >> isExtensionDependency [
	^ false
]

{ #category : #testing }
PDPackageDependency >> isExternal [
	^ self isInternal not
]

{ #category : #testing }
PDPackageDependency >> isInheritanceDependency [
	^ false 
]

{ #category : #testing }
PDPackageDependency >> isInternal [
	^ self source = self target
]

{ #category : #testing }
PDPackageDependency >> isReferenceDependency [
	^ false
]

{ #category : #testing }
PDPackageDependency >> isTraitDependency [
	^ false
]

{ #category : #accessing }
PDPackageDependency >> mySize [
	^ 1
]

{ #category : #printing }
PDPackageDependency >> printOn: aStream [
	self printReasonOn: aStream
]

{ #category : #printing }
PDPackageDependency >> printReasonOn: aStream [
	aStream 
		nextPutAll: source packageName;
		nextPutAll: ' -> ';
		nextPutAll: target packageName
]

{ #category : #printing }
PDPackageDependency >> printShortReasonOn: aStream [
	self printReasonOn: aStream
]

{ #category : #accessing }
PDPackageDependency >> reason [
	^ String streamContents: [ :stream | self printReasonOn: stream ]
]

{ #category : #accessing }
PDPackageDependency >> source [
	^ source
]

{ #category : #accessing }
PDPackageDependency >> target [
	^ target
]
