initialization
initializeWithPackageNames: aCollection
	packageAnalyzerTreeModel := PDPackageAnalyzerTreeModel onPackagesNamed: aCollection.
	self buildandAddAllMorph 