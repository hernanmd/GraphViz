accessing
allDependentPackagesFromSeenPackagesWithoutExtensionDependency
	| aSet |
	aSet := Set new.
	self seenPackages do: [ :seenPackage |
		aSet addAll: (seenPackage dependentPackagesWithoutExtensionDependency ) ].
	
	^ aSet	
