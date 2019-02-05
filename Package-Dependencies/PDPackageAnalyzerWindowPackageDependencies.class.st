"
UI merging SpecTreeModel cycles and Nautilus UI.
"
Class {
	#name : #PDPackageAnalyzerWindowPackageDependencies,
	#superclass : #PDPackageAnalyzerWindow,
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #nautilus }
PDPackageAnalyzerWindowPackageDependencies class >> browseDependencies: aBuilder [
	<contextMenu>
	<nautilusGlobalPackageMenu>
	|  selectedPackages |
	selectedPackages := self selectedPackagesFrom: aBuilder.

	(aBuilder item: #'Browse dependencies...')
		action: [ (PDPackageAnalyzerWindowPackageDependencies onPackagesNamed: selectedPackages) open ];
		order: 1000.
]

{ #category : #examples }
PDPackageAnalyzerWindowPackageDependencies class >> collections [
	^ (PDPackageAnalyzerWindowPackageDependencies
			onPackagesMatch: '*Collections*') open
]

{ #category : #'instance-creation' }
PDPackageAnalyzerWindowPackageDependencies class >> onPackagesMatch: match [
	^ (PDPackageAnalyzerWindowPackageDependencies
		onPackagesNamed:
			(RPackageOrganizer default packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) ) 
]

{ #category : #examples }
PDPackageAnalyzerWindowPackageDependencies class >> system [
	^ (PDPackageAnalyzerWindowPackageDependencies
			onPackagesNamed: self systemPackages) open 
]

{ #category : #initialization }
PDPackageAnalyzerWindowPackageDependencies >> initializeWithPackageNames: aCollection [
	packageAnalyzerTreeModel := PDPackageAnalyzerTreeModel onPackagesNamed: aCollection.
	self buildandAddAllMorph 
]

{ #category : #initialization }
PDPackageAnalyzerWindowPackageDependencies >> initializeWithRelationGraph: aRelationGraph [
	packageAnalyzerTreeModel := PDPackageAnalyzerReverseTreeModel onRelationGraph: aRelationGraph.
	self buildandAddAllMorph 
]
