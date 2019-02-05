actions
buildRoots
	| matching |
	self filter
		ifNotNil: [ 
			matching := '*' , self filter , '*'.
			self tree roots: (relationGraph seenPackagesWithFilter: matching) ]
		ifNil: [ self tree roots: relationGraph seenPackages ].
	self tree roots: self tree roots asSortedCollection.
	self treeWhenBuiltDo;
		updatePackageLabel.