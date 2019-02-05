"
Welcome user interface to browse dependencies packages. Availaible via tools menu.
"
Class {
	#name : #PDPackageDependenciesWelcome,
	#superclass : #ComposableModel,
	#instVars : [
		'packageLabel',
		'packageChosenLabel',
		'buttonOpen',
		'packageList',
		'packageChosenList',
		'buttonAddPackage',
		'buttonRemovePackage',
		'buttonAddAll',
		'buttonRemoveAll',
		'textPackageField'
	],
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #specs }
PDPackageDependenciesWelcome class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed
		newColumn:
			[ :col | 
			col
				newRow: [ :row | 
							row
								add: #packageLabel;
								add: #packageChosenLabel ]
					height: 30;
				newRow: [ :row | 
							row
								add: #textPackageField;
								add: #buttonOpen ]
					height: 30;
				newRow: [ :row | 
							row
								add: #buttonAddPackage;
								add: #buttonRemovePackage ]
					height: 30;
				newRow: [ :row | 
							row
								add: #packageList;
								add: #packageChosenList ];
				newRow: [ :row | 
							row
								add: #buttonAddAll;
								add: #buttonRemoveAll ]
					height: 30 ] yourself
]

{ #category : #'world menu' }
PDPackageDependenciesWelcome class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #PackageDependencies)
		order: 0.21;
		parent: #Tools;
		label: 'Package Dependencies Browser';
		icon: (Smalltalk ui icons iconNamed: #packageIcon);
		action: [ PDPackageDependenciesWelcome new open ]
]

{ #category : #protocol }
PDPackageDependenciesWelcome >> actionOnAddPackage [
	| itemsToAdd itemsChosen itemsAdded |
	buttonAddPackage
		action: [ 
			self selectedItemsFromPackageList
				ifNotEmpty: [ 
					itemsToAdd := self selectedItemsFromPackageList asOrderedCollection.
					itemsAdded := self itemsFromPackageChosenList asOrderedCollection.
					itemsChosen := self merge: itemsToAdd With: itemsAdded.
					self packageChosenList items: itemsChosen asSortedCollection.
					self updatePackageChosenLabel ] ]
]

{ #category : #protocol }
PDPackageDependenciesWelcome >> actionOnOpen [
	buttonOpen
		action: [ 
			self itemsFromPackageChosenList
				ifNotEmpty: [ 
					(PDPackageAnalyzerWindowPackageDependencies onPackagesNamed: self itemsFromPackageChosenList) open.
					 ] ]
]

{ #category : #protocol }
PDPackageDependenciesWelcome >> actionOnRemovePackage [
	| itemsAdded |
	buttonRemovePackage
		action: [ 
			self selectedItemsFromPackageChosenList
				ifNotEmpty: [ 
					itemsAdded := self itemsFromPackageChosenList.
					self selectedItemsFromPackageChosenList do: [ :each | itemsAdded remove: each ].
					self packageChosenList items: itemsAdded.
					self packageChosenList resetSelection.
					self updatePackageChosenLabel ] ]
]

{ #category : #actions }
PDPackageDependenciesWelcome >> buildList [
	self packageList items: self systemPackages.
	self updateLabels
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> buttonAddAll [
	^ buttonAddAll
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> buttonAddPackage [
	^ buttonAddPackage
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> buttonOpen [
	^ buttonOpen
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> buttonRemoveAll [
	^ buttonRemoveAll
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> buttonRemovePackage [
	^ buttonRemovePackage
]

{ #category : #initialization }
PDPackageDependenciesWelcome >> filterPackageList [
	| match itemsMatching |
	textPackageField text
		ifEmpty: [ self packageList items: self systemPackages ]
		ifNotEmpty: [ 
			match := '*' , textPackageField text , '*'.
			itemsMatching := self systemPackages select: [ :package | match match: package ].
			self packageList items: itemsMatching asSortedCollection ]
]

{ #category : #'morphic ui' }
PDPackageDependenciesWelcome >> initialExtent [
	^ (800@800)
]

{ #category : #initialization }
PDPackageDependenciesWelcome >> initializeButtons [
	buttonOpen := self newButton
		help: 'Open the package dependencies analysis';
		label: 'Browse dependencies';
		icon: (Smalltalk ui icons iconNamed: #packageIcon).
	buttonAddPackage := self newButton
		help: 'Add package to browse';
		label: 'Add package';
		icon: (Smalltalk ui icons iconNamed: #addIcon).
	buttonRemovePackage := self newButton
		help: 'Remove package to browse';
		label: 'Remove package';
		icon: (Smalltalk ui icons iconNamed: #removeIcon).
	buttonRemoveAll := self newButton
		help: 'Remove all selected packages';
		label: 'Remove all'.
	buttonAddAll := self newButton
		help: 'Add all packages';
		label: 'Add all'
]

{ #category : #initialization }
PDPackageDependenciesWelcome >> initializeLabels [
	packageLabel := self newLabel.
	packageChosenLabel := self newLabel
]

{ #category : #initialization }
PDPackageDependenciesWelcome >> initializeLists [
	packageList := self newList
		multiSelection: true;
		yourself.
	packageChosenList := self newList
		multiSelection: true;
		yourself
]

{ #category : #initialization }
PDPackageDependenciesWelcome >> initializePresenter [
	self actionOnOpen;
		actionOnAddPackage;
		actionOnRemovePackage.
	
	self buttonAddAll action: [ self packageChosenList items: self packageList listItems. self updatePackageChosenLabel ].
	self buttonRemoveAll action: [ self packageChosenList items: #().  self updatePackageChosenLabel ].
		
	packageChosenList whenSelectedItemChanged: [ packageList resetSelection ].
	
	textPackageField
		whenTextChanged: [ self filterPackageList ]
]

{ #category : #initialization }
PDPackageDependenciesWelcome >> initializeWidgets [
	self
		initializeLists;
		initializeLabels;
		initializeButtons;
		buildList.
		
	textPackageField := self newTextInput
		ghostText: 'Enter a package name';
		entryCompletion: self packagesEntryCompletion.
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> itemsFromPackageChosenList [
	^ self packageChosenList listItems
]

{ #category : #'as yet unclassified' }
PDPackageDependenciesWelcome >> merge: aCollection With: anOtherCollection [
	| merge |
	merge := Set new.
	aCollection do: [ :each | merge add: each ].
	anOtherCollection do: [ :each | merge add: each ].
	^ merge
]

{ #category : #actions }
PDPackageDependenciesWelcome >> open [
	^ self openWithSpec
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> packageChosenLabel [
	^ packageChosenLabel
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> packageChosenList [
	^ packageChosenList
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> packageLabel [
	^ packageLabel
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> packageList [
	^ packageList
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> packagesEntryCompletion [
	| applicants |
	applicants := self systemPackages.

	^ EntryCompletion new
				dataSourceBlock: [:currText | applicants];
				filterBlock: [:currApplicant :currText | currText size > 3
						and: [currApplicant asUppercase includesSubstring: currText asString asUppercase]].
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> selectedItemsFromPackageChosenList [
	^ self packageChosenList selectedItems
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> selectedItemsFromPackageList [
	^ self packageList selectedItems
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> systemPackages [
	^ (RPackageOrganizer default packages collect: [ :package | package packageName asString ] )asSortedCollection
]

{ #category : #accessing }
PDPackageDependenciesWelcome >> textPackageField [
	^ textPackageField
]

{ #category : #'morphic ui' }
PDPackageDependenciesWelcome >> title [
	^ 'Package Dependencies Browser'
]

{ #category : #protocol }
PDPackageDependenciesWelcome >> updateLabels [
	self
		updatePackageLabel;
		updatePackageChosenLabel
]

{ #category : #protocol }
PDPackageDependenciesWelcome >> updatePackageChosenLabel [
	self packageChosenLabel 
			label: packageChosenList listSize asString, ' package(s) chosen'.
]

{ #category : #protocol }
PDPackageDependenciesWelcome >> updatePackageLabel [
	self packageLabel 
			label: 'Choose your packages (', self packageList listSize asString, ' packages available)'.
]
