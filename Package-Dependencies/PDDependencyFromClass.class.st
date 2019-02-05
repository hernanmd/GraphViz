"
A PDDependencyFromClass is a dependency from the class. The source class is stored in the inst var.
"
Class {
	#name : #PDDependencyFromClass,
	#superclass : #PDPackageDependency,
	#instVars : [
		'theClass'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'as yet unclassified' }
PDDependencyFromClass >> <= other [
	self theClass <= other theClass
]

{ #category : #accessing }
PDDependencyFromClass >> theClass [
	^ theClass
]

{ #category : #accessing }
PDDependencyFromClass >> theClass: aClass [
	theClass := aClass
]
