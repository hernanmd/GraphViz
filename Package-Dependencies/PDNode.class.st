"
A PDNode is an abstract class for to display nodes in a tree.
"
Class {
	#name : #PDNode,
	#superclass : #TreeNodePresenter,
	#instVars : [
		'treeModelParent',
		'packageTreeNautilus',
		'packageTreeNautilusUI',
		'cycle'
	],
	#category : #'Package-Dependencies-UI-Node'
}

{ #category : #'as yet unclassified' }
PDNode >> browseClass: classToBrowse [
	Smalltalk tools browser fullOnClass: classToBrowse
]

{ #category : #'browse-nautilus' }
PDNode >> browseClassInNautilus: aClass [
	| nautilus |
	
	nautilus := self rootNode packageTreeNautilus.
	self setSelectionOnMethod: nil class: aClass with: nautilus.
	self refreshNautilus: nautilus.
]

{ #category : #'browse-nautilus' }
PDNode >> browseInNautilus [
	^ self subclassResponsibility
]

{ #category : #'browse-nautilus' }
PDNode >> browseInOtherNautilus [
	"do nothing by default"
]

{ #category : #'browse-nautilus' }
PDNode >> browseMethodInNautilus: aMethod [
	| classToBrowse nautilus compiledMethod nautilusUI |
	nautilus := self rootNode packageTreeNautilus.
	nautilusUI := self rootNode packageTreeNautilusUI.
	classToBrowse := aMethod methodClass.
	compiledMethod := classToBrowse>>aMethod selector.
	self setSelectionOnMethod: compiledMethod class: classToBrowse with: nautilus.
	nautilusUI
		changed:#sourceCodeFrom:;
		updateCategoryAndMethodList.
	
	
	
]

{ #category : #'browse-nautilus' }
PDNode >> browsePackageInNautilus: aPackage [
	| classToBrowse classFromPackage classesToBrowse |
	classFromPackage := aPackage classes.
	classesToBrowse := classFromPackage reject: [ :class | classFromPackage includes: class superclass ].
	classToBrowse := classesToBrowse isEmpty
		ifFalse: [ (classesToBrowse sorted: [ :a :b | a asString < b asString ]) first ].
	classToBrowse ifNotNil: [ self browseClassInNautilus: classToBrowse ]
]

{ #category : #accessing }
PDNode >> cycle: anObject [
	cycle := anObject
]

{ #category : #testing }
PDNode >> isClassToDependencyNode [
	^ false
]

{ #category : #accessing }
PDNode >> isCycle [
	^ cycle
]

{ #category : #accessing }
PDNode >> isCycleNode [
	^ false
]

{ #category : #accessing }
PDNode >> isExtensionCheckBoxChecked [
	^ self rootNode treeModelParent extensionCheckBox state
]

{ #category : #testing }
PDNode >> isPackageNode [
 	^ false
]

{ #category : #testing }
PDNode >> isReferenceNode [
	^ false
]

{ #category : #procotol }
PDNode >> nodeForDependency: anItem [
	anItem isExtensionDependency
		ifTrue: [ ^ PDExtensionDependencyNode ].
	anItem isReferenceDependency
		ifTrue: [ ^ PDReferenceDependencyNode ].
	anItem isInheritanceDependency
		ifTrue: [ ^ PDInheritanceDependencyNode ].
	^ PDTraitDependencyNode
]

{ #category : #accessing }
PDNode >> packageTreeNautilus [
	^ packageTreeNautilus
]

{ #category : #accessing }
PDNode >> packageTreeNautilus: anObject [
	packageTreeNautilus := anObject
]

{ #category : #accessing }
PDNode >> packageTreeNautilusUI [
	^ packageTreeNautilusUI
]

{ #category : #accessing }
PDNode >> packageTreeNautilusUI: anObject [
	packageTreeNautilusUI := anObject
]

{ #category : #'browse-nautilus' }
PDNode >> refreshNautilus: nautilus [

	| nautilusUI |
	nautilusUI := self rootNode packageTreeNautilusUI.
	nautilusUI updatePackageGroupAndClassList.
]

{ #category : #private }
PDNode >> rootNode [
	| rootNode currentNode |
	currentNode := self.
	rootNode := currentNode parentNode.
	[ rootNode isNil ]
		whileFalse: [ 
			currentNode := rootNode.
			rootNode := currentNode parentNode ].
	^ currentNode.
]

{ #category : #'browse-nautilus' }
PDNode >> setSelectionOnMethod: aMethod class: aClass with: nautilus [
	| protocol nautilusUI |
	aMethod ifNotNil: [ protocol := aMethod protocol ].
	nautilusUI := self rootNode packageTreeNautilusUI.
	self refreshNautilus: nautilus.
	nautilus
		browsedEnvironment: Nautilus defaultBrowsedEnvironment;
		showInstance: aClass isMeta not.
	nautilus
		package: aClass package
		class: aClass
		protocol: protocol
		method: aMethod.
	nautilusUI
		showHierarchy: nautilus showHierarchy not;
		giveFocusToMethod
]

{ #category : #accessing }
PDNode >> treeModelParent [
	^ treeModelParent
]

{ #category : #accessing }
PDNode >> treeModelParent: anObject [
	treeModelParent := anObject
]
