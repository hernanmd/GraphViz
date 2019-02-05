initialization
initializeWith: oldRelationGraph on: newRelationGraph
	packageRelationGraphDiff := PDPackageRelationGraphDiff new
		oldRelationGraph: oldRelationGraph;
		newRelationGraph: newRelationGraph.
	packageRelationGraphDiff make.
	
	self buildRoots
	
	