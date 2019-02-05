initialization-union
initializeWithPackageNames: aCollection
	packageAnalyzerTreeModel  := PDPackageCycleDetectionTreeModel  onPackagesNamed: aCollection.
	self buildandAddAllMorph 