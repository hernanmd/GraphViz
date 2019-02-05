protocol
actionOnOpen
	buttonOpen
		action: [ 
			self itemsFromPackageChosenList
				ifNotEmpty: [ 
					(PDPackageAnalyzerWindowPackageDependencies onPackagesNamed: self itemsFromPackageChosenList) open.
					 ] ]