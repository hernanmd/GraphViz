private
initializeGraph: graphName

	graph := GraphViz new.
	graph
		name: graphName;
		beDirected;
		add: 'graph' with: { 'overlap' -> 'scale'. 'concentrate' -> 'true'. 'ranksep' -> '0.25'. 'label' -> self repository asString };
		add: 'edge' with: { 'arrowsize' -> '1.0' };
		add: 'node' with: { 'shape' -> 'Mrecord' };	
		yourself.