"
Abstract class from package node displaying in the tree.
"
Class {
	#name : #PDAbstractPackageNode,
	#superclass : #PDNode,
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'browse-nautilus' }
PDAbstractPackageNode >> browseInNautilus [
	| packageToBrowse |
	packageToBrowse := self content rPackageSet.
	
	self browsePackageInNautilus: packageToBrowse.
]
