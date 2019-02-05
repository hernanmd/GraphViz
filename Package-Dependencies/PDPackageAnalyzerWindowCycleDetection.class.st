"
UI merging SpecTreeModel package dependencies and Nautilus UI.
"
Class {
	#name : #PDPackageAnalyzerWindowCycleDetection,
	#superclass : #PDPackageAnalyzerWindow,
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #examples }
PDPackageAnalyzerWindowCycleDetection class >> collections [
	^ (PDPackageAnalyzerWindowCycleDetection 
			onPackagesMatch: '*Collections*') open
]

{ #category : #'instance-creation' }
PDPackageAnalyzerWindowCycleDetection class >> onPackagesMatch: match [
	^ (PDPackageAnalyzerWindowCycleDetection
		onPackagesNamed:
			self systemPackages) open
]

{ #category : #examples }
PDPackageAnalyzerWindowCycleDetection class >> system [
	^ (PDPackageAnalyzerWindowCycleDetection new initializeWithFilter: self systemPackages) open
]

{ #category : #'initialization-filter' }
PDPackageAnalyzerWindowCycleDetection >> initializeCycleDetectionTreeModelWith: aCollection [

	self initializeWithSystemCycles.
	packageAnalyzerTreeModel filterWithPackages: aCollection
]

{ #category : #'initialization-filter' }
PDPackageAnalyzerWindowCycleDetection >> initializeWithFilter: aCollection [
	self initializeCycleDetectionTreeModelWith: aCollection.
	self buildandAddAllMorph
]

{ #category : #'initialization-union' }
PDPackageAnalyzerWindowCycleDetection >> initializeWithPackageNames: aCollection [
	packageAnalyzerTreeModel  := PDPackageCycleDetectionTreeModel  onPackagesNamed: aCollection.
	self buildandAddAllMorph 
]

{ #category : #'initialization-filter' }
PDPackageAnalyzerWindowCycleDetection >> initializeWithSystemCycles [
	packageAnalyzerTreeModel := PDPackageCycleDetectionTreeModel system.
]

{ #category : #update }
PDPackageAnalyzerWindowCycleDetection >> updateWithFilter: aCollectionOfPDPackages [
	self packageAnalyzerTreeModel filterWithPackages: aCollectionOfPDPackages.
]
