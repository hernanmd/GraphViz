"
A PDAbstractItemDiff is a object which represent a package who added/modified/removed from an old analysis.
"
Class {
	#name : #PDPackageItemDiff,
	#superclass : #PDAbstractItemDiff,
	#category : #'Package-Dependencies-Diff'
}

{ #category : #accessing }
PDPackageItemDiff >> dependencies [
	 ^ self content dependentPackages 
]

{ #category : #testing }
PDPackageItemDiff >> hasChanged [
	^ diff dependentPackagesDiff
		detect: [ :each | each parent = self content and: [ each hasChanged ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #printing }
PDPackageItemDiff >> printOn: aStream [
	aStream 
		nextPutAll: content packageName.
]
