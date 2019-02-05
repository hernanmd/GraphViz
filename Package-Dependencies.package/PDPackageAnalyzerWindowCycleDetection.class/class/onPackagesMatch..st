instance-creation
onPackagesMatch: match
	^ (PDPackageAnalyzerWindowCycleDetection
		onPackagesNamed:
			self systemPackages) open