"
A PDCycleNode is used to display a cycle in a tree.
"
Class {
	#name : #PDCycleNode,
	#superclass : #PDNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'browse-nautilus' }
PDCycleNode >> browseInNautilus [
	"we cannot browse a cycle in Nautilus"
	^ self
]

{ #category : #accessing }
PDCycleNode >> childNodeClassFor: anItem [
	^ PDPackageNode
]

{ #category : #accessing }
PDCycleNode >> children [
	^ self content packages
]

{ #category : #accessing }
PDCycleNode >> hasChildren [
	^ self content size > 0
]

{ #category : #accessing }
PDCycleNode >> icon [
		^ Smalltalk ui icons iconNamed: #refreshIcon
]

{ #category : #accessing }
PDCycleNode >> isCycleNode [
	^ true
]
