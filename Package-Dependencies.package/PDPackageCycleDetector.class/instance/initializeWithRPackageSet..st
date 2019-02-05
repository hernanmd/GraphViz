initialization
initializeWithRPackageSet: aCollection
	relation := PDPackageRelationGraph onPackages: (aCollection collect: [ :each | PDPackage on: each ]).
	cycles := OrderedCollection new.
	self relation build.
	sccs := PDTarjanAlgorithm new
		run: self relation;
		stronglyConnectedComponents