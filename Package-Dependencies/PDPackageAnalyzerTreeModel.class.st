"
A PDPackageAnalyzerTreeModel shows all dependent packages from a set of packages. Also you can see all type of the dependency, and browse them.
"
Class {
	#name : #PDPackageAnalyzerTreeModel,
	#superclass : #PDPackageTreeModel,
	#instVars : [
		'systemCycles',
		'packageLabel',
		'buttonBrowseCycles',
		'buttonDefault',
		'textPackageField',
		'filter',
		'buttonAddPackage',
		'buttonGenerateGraphViz',
		'buttonRemovePackage',
		'buttonReverseAnalysis',
		'buttonSave',
		'buttonMakeDiff',
		'relationGraph',
		'buttonChecker'
	],
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #specs }
PDPackageAnalyzerTreeModel class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn:
			[ :col | 
			col
				newRow: [ :row | 
							row
								add: #textPackageField;
								add: #buttonBrowseCycles;
								add: #buttonRefresh;
								add: #buttonDefault
								 ]
					height: 30;
				newRow: [ :row | 
							row
								add: #packageLabel;
								add: #extensionCheckBox ]
					height: 20;
				add: #tree;
				newRow: [ :row | 
							row
								add: #buttonAddPackage;
								add: #buttonRemovePackage;
								"add: #buttonGenerateGraphViz;"
								"add: #buttonMakeDiff;"
								add: #buttonReverseAnalysis
								 ]
					height: 30 ]	
					  yourself
]

{ #category : #'instance-creation' }
PDPackageAnalyzerTreeModel class >> onPackages: aCollection [
	^ self new
		initializeWithRPackageSet: aCollection;
		yourself
]

{ #category : #examples }
PDPackageAnalyzerTreeModel class >> onPackagesMatch: match [
	^ (PDPackageAnalyzerTreeModel
		onPackagesNamed:
			(RPackageOrganizer default packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) )
]

{ #category : #'instance-creation' }
PDPackageAnalyzerTreeModel class >> onPackagesNamed: aCollection [
	^ self onPackages: (aCollection collect: [ :each | RPackageSet named: each ])
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnAddPackage [
	self buttonAddPackage action: [ (PDAddPackageModel 
					new 
					packageAnalyzerTreeModel: self)
					open ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnBrowseCycles [
	buttonBrowseCycles action: [ self actionOnFindCycles ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnButtons [

	self
		actionOnBrowseCycles;
		actionWhenTextFieldChanged;
		actionOnDefaultSettings;
		actionOnRemovePackage;
		actionOnAddPackage;
		 actionOnGenerateGraphViz;
		actionOnReverseAnalysis;
		actionOnSave.
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnDefaultSettings [
	self buttonDefault
		action: [ 
			self resetDefaultSettings.
			self buildRoots ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnFindCycles [
	| selectedPackages selectedItems |
	selectedItems := self selectedItemsFromTree.
	^ (self arePackageNodes: selectedItems)
		ifTrue: [ 
			self notify: 'This could be a while, confirm?'.
			selectedPackages := self pdPackagesFrom: selectedItems.
			systemCycles ifNil: [ systemCycles := PDPackageAnalyzerWindowCycleDetection  system ].
			systemCycles
				updateWithFilter: selectedPackages;
				open ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnGenerateGraphViz [
	| graphvizGenerator |
	buttonGenerateGraphViz
		action: [  
			self ifGraphVizAbsent: [ self error: 'Please install Graphviz Support' ].
			graphvizGenerator := PDPackageRelationGraphGenerator newWith: self relationGraph named: 'PackageDependencyGraph'.
			self saveGraphAndOpenWith: graphvizGenerator ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnRemovePackage [
	| packagesToRemove |
	self buttonRemovePackage
		action: [ 
			self selectedItemsFromTree
				ifNotEmpty: [ 
					packagesToRemove := self selectedItemsFromTree.
					packagesToRemove do: [ :item | self relationGraph removePackage: item content packageName ].
					self buildRoots ] ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnReverseAnalysis [
	buttonReverseAnalysis action: [ 
		(PDPackageAnalyzerWindowPackageDependencies new 
						initializeWithRelationGraph: self relationGraph) 
					open ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionOnSave [
	self buttonSave 
		action: [ self saveCurrentRelationGraph ]
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> actionWhenTextFieldChanged [
	textPackageField
		whenTextChanged: [ 
			textPackageField text ifEmpty: [ self resetFilter ] ifNotEmpty: [ self filter: textPackageField text ].
			self buildRoots ]
]

{ #category : #actions }
PDPackageAnalyzerTreeModel >> buildRoots [
	| matching |
	self filter
		ifNotNil: [ 
			matching := '*' , self filter , '*'.
			self tree roots: (relationGraph seenPackagesWithFilter: matching) ]
		ifNil: [ self tree roots: relationGraph seenPackages ].
	self tree roots: self tree roots asSortedCollection.
	self treeWhenBuiltDo;
		updatePackageLabel.
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonAddPackage [
	^ buttonAddPackage
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonBrowseCycles [
	^ buttonBrowseCycles
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonChecker [
	^ buttonChecker
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonDefault [
	^ buttonDefault
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonGenerateGraphViz [
	^ buttonGenerateGraphViz
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonMakeDiff [
	^ buttonMakeDiff
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonRemovePackage [
	^ buttonRemovePackage
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonReverseAnalysis [
	^ buttonReverseAnalysis
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> buttonSave [
	^ buttonSave
]

{ #category : #saving }
PDPackageAnalyzerTreeModel >> createDirectoryForSaving [
	| dir |
	dir := FileSystem workingDirectory / self defaultDirectory.
	dir ensureCreateDirectory
]

{ #category : #saving }
PDPackageAnalyzerTreeModel >> defaultDirectory [
	^ 'saving'
]

{ #category : #saving }
PDPackageAnalyzerTreeModel >> defaultName [
	^ self defaultDirectory, '/relationGraph.FL'
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> extent [
	^ 700@500
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> filter [
	^ filter
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> filter: aString [
	filter := aString
]

{ #category : #initialization }
PDPackageAnalyzerTreeModel >> initializeButtons [
	buttonBrowseCycles := self newButton
		help: 'Find all the cycles where the package is in the system';
		label: 'Find cycles'.
	buttonDefault := self newButton
		help: 'Back to the default settings';
		label: 'Default settings'.
	buttonAddPackage := self newButton
		help: 'Add package to the current analysis';
		label: 'Add packages';
		icon: (Smalltalk ui icons iconNamed: #addIcon).
	buttonRemovePackage := self newButton
		help: 'Remove package to the current analysis';
		label: 'Remove packages';
		icon: (Smalltalk ui icons iconNamed: #removeIcon).
	buttonGenerateGraphViz := self newButton
		help: 'Open the graph in world';
		label: 'Open the graph'.
	buttonReverseAnalysis := self newButton
		help: 'Reverse the analysis : set the dependent packages as root packages';
		label: 'Reverse the analysis'.
	buttonSave := self newButton
		help: 'Serialize the current object relation graph dependencies';
		label: 'Save current analysis'.
	buttonMakeDiff := self newButton 
		label: 'Make diff'.
	buttonChecker := self newButton
		label: 'Run Extension Checker';
		help: 'Run Extension Checker for these packages'.
]

{ #category : #initialization }
PDPackageAnalyzerTreeModel >> initializePresenter [
	super initializePresenter.
	self actionOnButtons.
	tree
		whenSelectedItemChanged: [ :item | 
			item
				ifNil: [ buttonBrowseCycles enabled: false ]
				ifNotNil: [ 
					buttonBrowseCycles enabled: true.
					tree menu: [ :aMenu | self loadMenuFor: item in: aMenu ].
					self tree selectedItem browseInNautilus ] ]
]

{ #category : #initialization }
PDPackageAnalyzerTreeModel >> initializeWidgets [
	super initializeWidgets.
	
	packageLabel := self newLabel label: 'Analysis of packages'.
	
	textPackageField := self newTextInput
		ghostText: 'Enter a package name';
		entryCompletion: self packagesEntryCompletion.
	
	self initializeButtons
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> initializeWithRPackageSet: aCollection [
	self relationGraph: (PDPackageRelationGraph onPackages: (aCollection collect: [ :each | PDPackage on: each ]))
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> packageLabel [
	^ packageLabel
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> packagesEntryCompletion [
	| applicants |
	applicants := (RPackageOrganizer default packages collect: [ :package | package packageName asString ]).

	^ EntryCompletion new
				dataSourceBlock: [:currText | applicants];
				filterBlock: [:currApplicant :currText | currText size > 3
						and: [currApplicant asUppercase includesSubstring: currText asString asUppercase]].
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> pdPackagesFrom: selectedItems [
	^ selectedItems collect: [ :item | PDPackage on: (RPackageSet named: item content packageName asString) ]
]

{ #category : #actions }
PDPackageAnalyzerTreeModel >> refresh [
	self isOpen ifTrue: [  
			self relationGraph refreshGraph.
			self buildRoots].
		
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> relationGraph [
	^ relationGraph
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> relationGraph: anObject [
	relationGraph := anObject.
	self relationGraph build.
	self buildRoots
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> relationGraphOnReverse: anObject [
	relationGraph := anObject.
	self relationGraph build.
	self buildReverseRoots
]

{ #category : #actions }
PDPackageAnalyzerTreeModel >> resetDefaultSettings [
	self
		resetExtensionCheckBox;
		resetFilter.
	self textPackageField text: ''
]

{ #category : #actions }
PDPackageAnalyzerTreeModel >> resetFilter [
	^ self filter: nil
]

{ #category : #saving }
PDPackageAnalyzerTreeModel >> saveCurrentRelationGraph [
	self createDirectoryForSaving.
	^  FLSerializer serialize: relationGraph toFileNamed: self defaultName. 
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> seenPackagesName [
	^ self relationGraph seenPackagesName
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> sizeOfRoots [
	^ self treeRoots size
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> textPackageField [
	^ textPackageField
]

{ #category : #protocol }
PDPackageAnalyzerTreeModel >> title [
	^ 'Dependencies analysis'
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> treeRoots [
	^ self tree roots
]

{ #category : #actions }
PDPackageAnalyzerTreeModel >> treeWhenBuiltDo [
	self tree
		whenBuiltDo: [ 
			tree
				rootNodeHolder: [ :item | 
					PDPackageNode new
						content: item;
						treeModelParent: self;
						packageTreeNautilus: self packageTreeNautilus;
						packageTreeNautilusUI: self packageTreeNautilusUI;
						cycle: false ] ]
]

{ #category : #accessing }
PDPackageAnalyzerTreeModel >> updatePackageLabel [
	self packageLabel label: 'Analysis of ' , self sizeOfRoots asString , ' package(s)'
]
