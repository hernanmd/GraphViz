examples
onPackagesMatch: match
	^ (PDPackageAnalyzerTreeModel
		onPackagesNamed:
			(RPackageOrganizer default packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) )