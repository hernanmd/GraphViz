build items
buildGraphViz
	graphviz := GraphViz new.
	graphviz
		beDirected;
		name: self nameOfGraph.
	graphviz add: #node with: {(#shape -> #box)}.
	graphviz add: #graph with: { (#label -> self nameOfGraph). (#fontsize -> 20) }.	
	
	self
		buildNodes;
		buildEdges.