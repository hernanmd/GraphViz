"
A PDDependentPackageItemDiff is a object which represent a dependent package who added/modified/removed from an old analysis.
"
Class {
	#name : #PDDependentPackageItemDiff,
	#superclass : #PDAbstractItemDiff,
	#instVars : [
		'parent'
	],
	#category : #'Package-Dependencies-Diff'
}

{ #category : #testing }
PDDependentPackageItemDiff >> hasChanged [
	^ self isNew or: [ self isRemoved ].
]

{ #category : #accessing }
PDDependentPackageItemDiff >> parent [
	^ parent
]

{ #category : #accessing }
PDDependentPackageItemDiff >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
PDDependentPackageItemDiff >> printOn: aStream [ 
	aStream 
		nextPutAll: content packageName;
		nextPutAll: ' Parent : ';
		nextPutAll: self parent packageName
]
