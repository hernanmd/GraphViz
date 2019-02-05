instance-creation
system
	^ (PDPackageCycleDetector onPackagesNamed: (RPackageOrganizer default packages collect: [ :package | package packageName asString ])) runAlgorithm.