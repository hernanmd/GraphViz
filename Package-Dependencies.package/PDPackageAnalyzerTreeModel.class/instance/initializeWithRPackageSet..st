accessing
initializeWithRPackageSet: aCollection
	self relationGraph: (PDPackageRelationGraph onPackages: (aCollection collect: [ :each | PDPackage on: each ]))