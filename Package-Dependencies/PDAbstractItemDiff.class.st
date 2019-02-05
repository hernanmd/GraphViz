"
A PDAbstractItemDiff is a object which represent an item who added/modified/removed from an old analysis.
"
Class {
	#name : #PDAbstractItemDiff,
	#superclass : #Object,
	#instVars : [
		'new',
		'underteminate',
		'content',
		'diff',
		'removed'
	],
	#category : #'Package-Dependencies-Diff'
}

{ #category : #'instance creation' }
PDAbstractItemDiff class >> newWith: aContent [
	^ (self new)
		content: aContent;
		yourself
]

{ #category : #actions }
PDAbstractItemDiff >> beNew [
	new := true
]

{ #category : #actions }
PDAbstractItemDiff >> beRemoved [
	removed := true
]

{ #category : #testing }
PDAbstractItemDiff >> beUnderteminate [
	underteminate := true
]

{ #category : #testing }
PDAbstractItemDiff >> canBeDisplay [
	^ (self isNew or: [ self isRemoved ]) or: [ self hasChanged ].
]

{ #category : #accessing }
PDAbstractItemDiff >> content [
	 ^ content
]

{ #category : #accessing }
PDAbstractItemDiff >> content: aContent [
	content := aContent
]

{ #category : #accessing }
PDAbstractItemDiff >> diff [
	^ diff
]

{ #category : #accessing }
PDAbstractItemDiff >> diff: anObject [
	diff := anObject
]

{ #category : #'as yet unclassified' }
PDAbstractItemDiff >> hasChanged [
	self subclassResponsibility 
]

{ #category : #initialization }
PDAbstractItemDiff >> initialize [
	new := false.
	removed := false.
	underteminate := false
]

{ #category : #testing }
PDAbstractItemDiff >> isNew [
	^ new
]

{ #category : #testing }
PDAbstractItemDiff >> isRemoved [
	^ removed
]

{ #category : #testing }
PDAbstractItemDiff >> isUnderteminate [
	 ^ underteminate 
]

{ #category : #printing }
PDAbstractItemDiff >> printOn: aStream [
	self subclassResponsibility 
]
