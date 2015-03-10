*GraphVizExamples
addJavaFamily: graph
	
	| famColor |
	
	famColor := #darkolivegreen2.
	graph 
		addLabel: 'Athena' fillColor: famColor ;
		addLabel: 'Java' fillColor: famColor ;
		add: 'Java' -> 'Athena';
		add: 'Smalltalk' -> 'Athena';
		
		addLabel: 'Bistro' fillColor: famColor ;
		add: 'Smalltalk' -> 'Bistro';
		add: 'Java' -> 'Bistro';

		addLabel: 'Redline' fillColor: famColor ;
		add: 'Smalltalk' -> 'Redline';
		add: 'Java' -> 'Redline';

		addLabel: 'Talks2' fillColor: famColor ;
		add: 'Java' -> 'Talks2';
		
		addLabel: 'Gravel' fillColor: famColor;
		add: 'Smalltalk' -> 'Gravel';
		add: 'Java' -> 'Gravel'.