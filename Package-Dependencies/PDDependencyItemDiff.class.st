"
A PDDependencyItemDiff is a object which represent a dependent package who added/removed from an old analysis.
"
Class {
	#name : #PDDependencyItemDiff,
	#superclass : #PDAbstractItemDiff,
	#category : #'Package-Dependencies-Diff'
}

{ #category : #printing }
PDDependencyItemDiff >> printOn: aStream [
	aStream 
		nextPutAll: self content asString.
]
