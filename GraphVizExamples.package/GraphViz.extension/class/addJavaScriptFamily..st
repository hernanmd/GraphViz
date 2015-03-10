*GraphVizExamples
addJavaScriptFamily: graph
	
	| famColor |
	
	famColor := #darkseagreen3.
	graph 
		addLabel: 'Clamato' fillColor: famColor ;
		add: 'Smalltalk' -> 'Clamato';
		addLabel: 'JavaScript' fillColor: famColor ;
		add: 'JavaScript' -> 'Clamato';

		addLabel: 'S8' fillColor: famColor ;
		add: 'Clamato' -> 'S8';
		addLabel: 'JTalk' fillColor: famColor ;
		add: 'JTalk' -> 'S8';

		add: 'Smalltalk' -> 'JTalk';
		add: 'JavaScript' -> 'JTalk';

		addLabel: 'Amber' fillColor: famColor ;
		add: 'JTalk' -> 'Amber';
		
		addLabel: 'SqueakJS' fillColor: famColor;
		add: 'JavaScript' -> 'SqueakJS';
		addLabel: 'Squeak' fillColor: #palegreen;
		add: 'Squeak' -> 'SqueakJS'.
