instance-creation
onPackagesMatch: match
	^ (PDPackageAnalyzerWindowPackageDependencies
		onPackagesNamed:
			(RPackageOrganizer default packages
				select: [ :package | match match: package packageName asString ]
				thenCollect: [ :package | package packageName ]) ) 