*GraphVizExamples
addObjectiveCFamilty: graph

	| famColor |
	
	famColor := #mintcream.
	graph 
		addLabel: 'StepTalk' fillColor: famColor;
		addLabel: 'Objective-C' fillColor: famColor;
		add: 'Smalltalk' -> 'StepTalk';
		add: 'Objective-C' -> 'StepTalk'