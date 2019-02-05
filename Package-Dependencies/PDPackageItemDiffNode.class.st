"
A PDPackageNode is used to display a package diff in a tree.
"
Class {
	#name : #PDPackageItemDiffNode,
	#superclass : #TreeNodeModel,
	#category : #'Package-Dependencies-Diff'
}

{ #category : #accessing }
PDPackageItemDiffNode >> icon [
	self content isNew ifTrue: [ ^ Smalltalk ui icons iconNamed: #changeAddIcon ].
	self content isRemoved ifTrue: [^ Smalltalk ui icons iconNamed: #smallCancelIcon ].
	^ Smalltalk ui icons iconNamed: #forwardIcon
]
