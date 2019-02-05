"
A PDPackageAnalyzerWindow class is an abstract class.
It represents the UI merging the SpecTreeModel (package dependencies or cycles) and Nautilus UI.

The main feature is to browse automatically in the Nautilus when you click on a node (package or dependency).

"
Class {
	#name : #PDPackageAnalyzerWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'packageAnalyzerTreeModel',
		'nautilus',
		'nautilusUI'
	],
	#category : 'Package-Dependencies-UI-Window'
}

{ #category : #'instance-creation' }
PDPackageAnalyzerWindow class >> onPackagesNamed: aCollection [

	^ self new initializeWithPackageNames: aCollection; yourself
]

{ #category : #accesing }
PDPackageAnalyzerWindow class >> selectedPackagesFrom: aBuilder [
	| target selectedPackages |
	target := aBuilder model.
	selectedPackages := target selectedPackages collect: [ :rpackage | rpackage packageName asString ].
	^ selectedPackages
]

{ #category : #examples }
PDPackageAnalyzerWindow class >> systemPackages [
	^ RPackageOrganizer default packages collect: [ :package | package packageName asString ]
]

{ #category : #adding }
PDPackageAnalyzerWindow >> addAllMorph [
	| windowNautilus  windowTreeModel |
	windowNautilus := self buildWindowNautilus.	
	windowTreeModel := self buildMorphWindowForTreeModel.
	packageAnalyzerTreeModel packageTreeNautilusUI: self nautilusUI.
	self
		addMorph: windowNautilus frame: (0.4 @ 0 corner: 1 @ 1);
		addMorph:  (self panelMorphFrom: windowTreeModel) frame: (0 @ 0 corner: 0.4 @ 1);
		yourself.
]

{ #category : #building }
PDPackageAnalyzerWindow >> buildMorphWindowForTreeModel [
	| specWindow |
	packageAnalyzerTreeModel
		open;
		delete.
	
	specWindow := self specWindowFrom: packageAnalyzerTreeModel.
	^ specWindow
]

{ #category : #building }
PDPackageAnalyzerWindow >> buildWindowNautilus [
	| windowNautilus |
	nautilusUI := NautilusUI on: nautilus.
	windowNautilus := NautilusWindow new model: nautilusUI.
	nautilusUI addAll: windowNautilus.
	nautilusUI window: windowNautilus.
	nautilusUI changed: #sourceCodeFrom:.
	nautilusUI setWindowTitle.
	^ windowNautilus
]

{ #category : #'initialization-filter' }
PDPackageAnalyzerWindow >> buildandAddAllMorph [
	nautilus := packageAnalyzerTreeModel packageTreeNautilus.
	self addAllMorph
]

{ #category : #'morphic ui' }
PDPackageAnalyzerWindow >> defaultLabel [
	^ 'Package Dependencies Analysis'
]

{ #category : #'as yet unclassified' }
PDPackageAnalyzerWindow >> delete [
	self packageAnalyzerTreeModel close.
	^ super delete
]

{ #category : #'morphic ui' }
PDPackageAnalyzerWindow >> initialExtent [
	^ (1500@800)
]

{ #category : #accessing }
PDPackageAnalyzerWindow >> nautilus [
	^ nautilus
]

{ #category : #accessing }
PDPackageAnalyzerWindow >> nautilusUI [
	^ nautilusUI
]

{ #category : #accessing }
PDPackageAnalyzerWindow >> open [
	^ self openInWorld.
	
]

{ #category : #accessing }
PDPackageAnalyzerWindow >> packageAnalyzerTreeModel [
	^ packageAnalyzerTreeModel
]

{ #category : #adding }
PDPackageAnalyzerWindow >> panelMorphFrom: aSpecWindow [
	aSpecWindow submorphs
		do: [ :submorph | 
			(submorph isKindOf: PanelMorph)
				ifTrue: [ ^ submorph ] ].
	^ nil
]

{ #category : #building }
PDPackageAnalyzerWindow >> specWindowFrom: aSpec [
	| windowModel specWindow |
	windowModel := aSpec window.
	specWindow := windowModel window.
	^ specWindow
]
