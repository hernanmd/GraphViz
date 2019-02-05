actions
build: graphName

	self 
		initializeGraph: graphName; 
		initializeVersions.
	self 
		buildNodes; 
		buildEdgesAncestry; 
		buildEdgesDependencies.