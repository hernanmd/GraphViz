*GraphVizExamples
addLittleSmalltalkFamily: graph
	
	| famColor |
	
	famColor := #darkslategray4.
	graph 
		addLabel: 'Little Smalltalk' fillColor: famColor;
		add: 'Smalltalk' -> 'Little Smalltalk';
		addLabel: 'SmallWorld' fillColor: famColor;
		add: 'Little Smalltalk' -> 'SmallWorld';
		addLabel: 'Susie' fillColor: famColor;
		add: 'Little Smalltalk' -> 'Susie';
		addLabel: 'Parla' fillColor: famColor;
		add: 'Little Smalltalk' -> 'Parla';
		addLabel: 'PDST' fillColor: famColor;
		add: 'Little Smalltalk' -> 'PDST';
		addLabel: 'Tumbleweed' fillColor: famColor;
		add: 'Little Smalltalk' -> 'Tumbleweed';
		addLabel: 'Amigatalk' fillColor: famColor;
		add: 'Little Smalltalk' -> 'Amigatalk'
		