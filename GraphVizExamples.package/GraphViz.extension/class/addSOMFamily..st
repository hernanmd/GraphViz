*GraphVizExamples
addSOMFamily: graph
	
	| famColor |
	
	self flag: #needsWork.
	famColor := #burlywood.
	graph 
		addLabel: 'AweSOM' fillColor: famColor;
		addLabel: 'NXTalk' fillColor: famColor;
		addLabel: 'SOM' fillColor: famColor;
		add: 'SOM' -> 'AweSOM	';
		add: 'SOM' -> 'NXTalk';
		add: 'Smalltalk' -> 'SOM'.