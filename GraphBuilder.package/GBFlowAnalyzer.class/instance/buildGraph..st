building
buildGraph: graphName

	graph := GraphViz new.
	graph
		beDirected;
		name: graphName;
		add: #graph with: { #overlap -> #scale. #concentrate -> true. #ranksep -> 0.25 };
		add: #edge with: { #arrowsize -> '1.0' }.
