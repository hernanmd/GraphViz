actions
build
	self initializeGraph; initializeVersions.
	self buildNodes; buildEdgesAncestry; buildEdgesDependencies.