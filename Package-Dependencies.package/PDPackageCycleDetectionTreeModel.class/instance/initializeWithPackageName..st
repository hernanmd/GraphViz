initialization
initializeWithPackageName: aCollection
	
	self analysis:  (PDPackageCycleDetector onPackagesNamed: aCollection) runAlgorithm.
	
	self cycles: self analysis cycles.