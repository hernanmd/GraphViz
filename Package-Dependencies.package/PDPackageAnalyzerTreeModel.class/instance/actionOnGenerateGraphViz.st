protocol
actionOnGenerateGraphViz
	| graphvizGenerator |
	buttonGenerateGraphViz
		action: [  
			self ifGraphVizAbsent: [ self error: 'Please install Graphviz Support' ].
			graphvizGenerator := PDPackageRelationGraphGenerator newWith: self relationGraph named: 'PackageDependencyGraph'.
			self saveGraphAndOpenWith: graphvizGenerator ]