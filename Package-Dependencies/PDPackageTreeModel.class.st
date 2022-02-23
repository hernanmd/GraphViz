"
A PDPackageTreeModel is an abstract class. It's a the superclass of the two tree model vizualisations (package dependency and cycle detection).
"
Class {
	#name : #PDPackageTreeModel,
	#superclass : #ComposableModel,
	#instVars : [
		'tree',
		'extensionCheckBox',
		'packageTreeNautilus',
		'buttonRefresh',
		'packageTreeNautilusUI',
		'open'
	],
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #private }
PDPackageTreeModel >> actionOnExtensionCheckBox [
	extensionCheckBox whenChangedDo: [ self buildRoots ].
]

{ #category : #private }
PDPackageTreeModel >> actionOnRefresh [
	buttonRefresh action: [ self refresh ]
]

{ #category : #actions }
PDPackageTreeModel >> addCycleOptionsFor: selected on: menuGroup [
	| cycleNodeSelected cycle graphvizGenerator |
	cycleNodeSelected := selected first.
	cycleNodeSelected isCycleNode
		ifTrue: [ 
			menuGroup
				addMenuItem:
					(MenuItemModel new
						name: 'Generate GraphViz file';
						action: [ 
									self ifGraphVizAbsent: [ self error: 'Please install Graphviz Support' ].
									cycle := cycleNodeSelected content.
									graphvizGenerator := PDPackageCycleGenerator newWith: cycle named: 'CycleGraph' , cycle size asString , 'nodes'.
									self saveGraphAndOpenWith: graphvizGenerator.
									 ]) ]
]

{ #category : #actions }
PDPackageTreeModel >> addDependenciesOptionsFor: selectedNodes on: menuGroup [
	| namesOfSelected |
	(self areClassToDependencyNodes: selectedNodes)
		ifTrue: [ 
			namesOfSelected := selectedNodes collect: [ :package | package content theClass ].
			menuGroup
				addMenuItem:
					(MenuItemModel new
						name: 'Browse dependencies from class';
						action: [ self openTreeFor: namesOfSelected ]) ]
]

{ #category : #actions }
PDPackageTreeModel >> addPackageOptionsFor: selectedPackages on: menuGroup [
	| namesOfSelectedPackage |
	(self arePackageNodes: selectedPackages)
		ifTrue: [ 
			namesOfSelectedPackage := selectedPackages collect: [ :package | package content packageName ].
			menuGroup
				addMenuItem:
					(MenuItemModel new
						name: 'Browse scoped dependencies';
						action: [ (PDPackageAnalyzerWindowPackageDependencies onPackagesNamed: namesOfSelectedPackage) open ]).
			selectedPackages size > 1
				ifTrue: [ 
					menuGroup
						addMenuItem:
							(MenuItemModel new
								name: 'Find cycles among packages';
								action: [ (PDPackageAnalyzerWindowCycleDetection onPackagesNamed: namesOfSelectedPackage) open ]) ] ]
]

{ #category : #testing }
PDPackageTreeModel >> areClassToDependencyNodes: aCollectionOfItem [
	^ aCollectionOfItem allSatisfy: [ :node |  node isClassToDependencyNode ].
]

{ #category : #testing }
PDPackageTreeModel >> arePackageNodes: aCollectionOfItem [
	^ aCollectionOfItem allSatisfy: [ :node |  node isPackageNode ].
]

{ #category : #initialization }
PDPackageTreeModel >> browseReference [
	self selectedItemFromTree isReferenceNode ifTrue: [ 
			self selectedItemFromTree browseReference
		 ]
]

{ #category : #private }
PDPackageTreeModel >> buildRoots [
	self subclassResponsibility.
]

{ #category : #accessing }
PDPackageTreeModel >> buttonRefresh [
	^ buttonRefresh
]

{ #category : #actions }
PDPackageTreeModel >> close [
	open := false
]

{ #category : #protocol }
PDPackageTreeModel >> defaultFormat [
	^ #png
]

{ #category : #accessing }
PDPackageTreeModel >> extensionCheckBox [
	^ extensionCheckBox
]

{ #category : #testing }
PDPackageTreeModel >> ifGraphVizAbsent: aBlock [

	Smalltalk at: #GraphViz ifAbsent: aBlock
]

{ #category : #initialization }
PDPackageTreeModel >> initializePresenter [
	self actionOnExtensionCheckBox;
	actionOnRefresh
]

{ #category : #initialization }
PDPackageTreeModel >> initializeWidgets [
	tree := self newTree
		multiSelection: true;
		on: $b command
			do: [ self selectedItemFromTree browseInOtherNautilus ];
		yourself.
	extensionCheckBox := self newCheckBox.
	extensionCheckBox label: 'Show extension dependencies'.
	buttonRefresh := self newButton
		icon:
			(self iconNamed: #refreshIcon);
		help: 'Refresh the TreeModel';
		label: 'Refresh'.
	packageTreeNautilus := Smalltalk tools browser
]

{ #category : #testing }
PDPackageTreeModel >> isOpen [
	^ open
]

{ #category : #actions }
PDPackageTreeModel >> loadMenuFor: item in: aMenu [
	| menuGroup selected |
	selected := self selectedItemsFromTree.
	menuGroup := MenuGroupModel new.
	self addPackageOptionsFor: selected on: menuGroup.
	self addDependenciesOptionsFor: selected asSet on: menuGroup.
	self addCycleOptionsFor: selected on: menuGroup.
	
	aMenu addMenuGroup: menuGroup.
	^ aMenu
]

{ #category : #'instance creation' }
PDPackageTreeModel >> open [
	open := true.
	^ self openWithSpec 
]

{ #category : #actions }
PDPackageTreeModel >> openTreeFor: namesOfSelected [
	| treeToOpen relationGraph |
	treeToOpen := TreeModel new.
	relationGraph := self tree owner relationGraph.
	^ treeToOpen
		roots: namesOfSelected;
		whenBuiltDo: [ 
					treeToOpen
						rootNodeHolder: [ :item | 
							PDClassToDependencyNode new
								content: item;
								package: (relationGraph pdPackageFrom: item) ] ];
		title: 'Class dependencies';
		extent: 700 @ 500;
		openWithSpec
]

{ #category : #accessing }
PDPackageTreeModel >> packageTreeNautilus [
	^ packageTreeNautilus
]

{ #category : #accessing }
PDPackageTreeModel >> packageTreeNautilusUI [
	^ packageTreeNautilusUI
]

{ #category : #accessing }
PDPackageTreeModel >> packageTreeNautilusUI: anObject [
	packageTreeNautilusUI := anObject.
	"have to rebuild the roots, because the Nautilus UI just changed"
	self buildRoots
]

{ #category : #actions }
PDPackageTreeModel >> refresh [
	self subclassResponsibility 
]

{ #category : #actions }
PDPackageTreeModel >> resetExtensionCheckBox [
	self extensionCheckBox state: false
]

{ #category : #protocol }
PDPackageTreeModel >> saveGraphAndOpenWith: graphvizGenerator [
	graphvizGenerator saveDotFileAndGenerateForType: self defaultFormat.
	^ graphvizGenerator openWith: self defaultFormat
]

{ #category : #actions }
PDPackageTreeModel >> selectedItemFromTree [
	^ self tree selectedItem
]

{ #category : #accessing }
PDPackageTreeModel >> selectedItemsFromTree [
	^ self tree selectedItems
]

{ #category : #accessing }
PDPackageTreeModel >> tree [
	^ tree
]
