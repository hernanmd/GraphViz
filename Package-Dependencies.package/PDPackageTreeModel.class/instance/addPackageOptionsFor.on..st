actions
addPackageOptionsFor: selectedPackages on: menuGroup
	| namesOfSelectedPackage |
	(self arePackageNodes: selectedPackages)
		ifTrue: [ 
			namesOfSelectedPackage := selectedPackages collect: [ :package | package content packageName ].
			menuGroup
				addMenuItem:
					(MenuItemModel new
						name: 'Browse scoped dependencies';
						action: [ (PDPackageAnalyzerWindowPackageDependencies onPackagesNamed: namesOfSelectedPackage) open ]).
			selectedPackages size > 1
				ifTrue: [ 
					menuGroup
						addMenuItem:
							(MenuItemModel new
								name: 'Find cycles among packages';
								action: [ (PDPackageAnalyzerWindowCycleDetection onPackagesNamed: namesOfSelectedPackage) open ]) ] ]