private
buildRoots
	| collectionOfWrapper |
	collectionOfWrapper := relationGraph allDependentPackagesFromSeenPackages
		collect: [ :package | package asDependentPackageWrapperOn: relationGraph ].
	
	self tree roots: collectionOfWrapper asSortedCollection.
	self 
		treeWhenBuiltDo;
		updatePackageLabel.