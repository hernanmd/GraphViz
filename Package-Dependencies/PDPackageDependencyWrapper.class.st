"
Wrapper for dependent package (use in TreeModel)
"
Class {
	#name : #PDPackageDependencyWrapper,
	#superclass : #Object,
	#instVars : [
		'pdPackage'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDPackageDependencyWrapper class >> newWith: aPackage [
	^ self new initializeFrom: aPackage
]

{ #category : #'as yet unclassified' }
PDPackageDependencyWrapper >> <= other [
	^ self pdPackage <= other pdPackage
]

{ #category : #accessing }
PDPackageDependencyWrapper >> asString [
	^ self packageName
]

{ #category : #initialization }
PDPackageDependencyWrapper >> initializeFrom: aPackage [
	super initialize.
	self pdPackage: aPackage.
]

{ #category : #accessing }
PDPackageDependencyWrapper >> packageName [
	^ pdPackage packageName
]

{ #category : #accessing }
PDPackageDependencyWrapper >> pdPackage [
	^ pdPackage
]

{ #category : #accessing }
PDPackageDependencyWrapper >> pdPackage: anObject [
	pdPackage := anObject
]

{ #category : #accessing }
PDPackageDependencyWrapper >> rPackageSet [
	^ pdPackage rPackageSet
]
