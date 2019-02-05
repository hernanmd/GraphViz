instance-creation
morphic
	^ (PDPackageCycleDetector onPackagesNamed: #('Morphic-Base' 'Morphic-Core' 'Morphic-Examples' 'MorphicTests' 'Spec-MorphicAdapters')) runAlgorithm.