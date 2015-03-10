*GraphVizExamples
addSelfFamily: graph
	
	| famColor |
	
	famColor := #burlywood.
	graph 
		addLabel: 'Self' fillColor: famColor;
		addLabel: 'CLOS' fillColor: famColor;
		addLabel: 'Slate' fillColor: famColor;
		add: 'Self' -> 'Slate';
		add: 'CLOS' -> 'Slate';
		add: 'Smalltalk' -> 'Slate'.