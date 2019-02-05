nautilus
browseDependencies: aBuilder
	<contextMenu>
	<nautilusGlobalPackageMenu>
	|  selectedPackages |
	selectedPackages := self selectedPackagesFrom: aBuilder.

	(aBuilder item: #'Browse dependencies...')
		action: [ (PDPackageAnalyzerWindowPackageDependencies onPackagesNamed: selectedPackages) open ];
		order: 1000.