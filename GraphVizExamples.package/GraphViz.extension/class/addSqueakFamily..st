*GraphVizExamples
addSqueakFamily: graph
	
	| famColor |
	
	famColor := #palegreen.
	graph 
		addLabel: 'Squeak' fillColor: famColor ;
		add: 'Smalltalk' -> 'Squeak';
	
		addLabel: 'Talks2' fillColor: famColor ;
		add: 'Squeak' -> 'Talks2';

		addLabel: 'Spoon' fillColor: famColor ;
		add: 'Squeak' -> 'Spoon';
	
		addLabel: 'Pharo' fillColor: famColor ;
		add: 'Squeak' -> 'Pharo';

		addLabel: 'Scratch' fillColor: famColor ;
		add: 'Squeak' -> 'Scratch';
	
		addLabel: 'Phratch' fillColor: famColor ;
		add: 'Scratch' -> 'Phratch';	
			
		addLabel: 'Phratch' fillColor: famColor ;
		add: 'Pharo' -> 'Phratch';	

		addLabel: 'Cuis' fillColor: famColor ;
		add: 'Squeak' -> 'Cuis';

		addLabel: 'Open Cobalt' fillColor: famColor ;
		addLabel: 'Croquet' fillColor: famColor ;
		add: 'Croquet' -> 'Open Cobalt';

		addLabel: 'OpenQwaq' fillColor: famColor ;
		add: 'Croquet' -> 'OpenQwaq';

		addLabel: 'Croquet' fillColor: famColor ;
		add: 'Squeak' -> 'Croquet';
	
		addLabel: 'EToys' fillColor: famColor ;
		add: 'Squeak' -> 'EToys'.