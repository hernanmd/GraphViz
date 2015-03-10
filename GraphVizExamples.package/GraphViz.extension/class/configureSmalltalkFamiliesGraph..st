*GraphVizExamples
configureSmalltalkFamiliesGraph: graph	
	
	graph
		beDirected;
		name: 'FamiliesOfSmalltalk';
		add: #graph with: {
			#labelloc -> 'top' .
			#label -> 'Families of Smalltalk' . 
			#fontsize -> 30 .
			#rankdir -> 'LR'	};
		add: #node with: {
			#fillcolor -> #lightyellow1 . 
			#shape -> #rectangle . 
			#fontsize -> 16}.