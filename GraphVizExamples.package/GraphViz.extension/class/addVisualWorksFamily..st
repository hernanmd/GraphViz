*GraphVizExamples
addVisualWorksFamily: graph
	
	| famColor |
	
	famColor := #lightgrey.
	graph 
		addLabel: 'VisualWorks' fillColor: famColor;
		addLabel: 'ObjectWorks' fillColor: famColor;
		add: 'Smalltalk' -> 'ObjectWorks' -> 'VisualWorks';
		addLabel: 'LearningWorks' fillColor: famColor;
		add: 'VisualWorks' -> 'LearningWorks';
		addLabel: 'NeoClassTalk' fillColor: famColor;
		add: 'VisualWorks' -> 'NeoClassTalk';
		addLabel: 'MetaclassTalk' fillColor: famColor;
		add: 'NeoClassTalk' -> 'MetaclassTalk'