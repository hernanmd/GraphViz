*GraphVizExamples
addDigitalkFamily: graph
	
	| famColor |
	
	famColor := #palegoldenrod.
	graph 
		addLabel: 'Digitalk Methods' fillColor: famColor ;
		addLabel: 'Smalltalk/V' fillColor: famColor ;
		add: 'Smalltalk' -> 'Digitalk Methods' -> 'Smalltalk/V';
		
		addLabel: 'Smalltalk/V Win - OS/2' fillColor: famColor ;
		add: 'Digitalk Methods' -> 'Smalltalk/V Win - OS/2';

		addLabel: 'VisualSmalltalk for Windows (VSW)' fillColor: famColor ;
		add: 'Smalltalk/V Win - OS/2' -> 'VisualSmalltalk for Windows (VSW)';
		addLabel: 'VisualSmalltalk Enterprise (VSE)' fillColor: famColor ;
		add: 'Smalltalk/V Win - OS/2' -> 'VisualSmalltalk Enterprise (VSE)';
		addLabel: 'LSW Vision-Smalltalk' fillColor: famColor ;
		add: 'VisualSmalltalk Enterprise (VSE)' -> 'LSW Vision-Smalltalk';
		addLabel: 'Smalltalk/V-Mac' fillColor: famColor ;
		add: 'Digitalk Methods' -> 'Smalltalk/V-Mac';
		addLabel: 'Smalltalk/V 286/386' fillColor: famColor ;
		add: 'Digitalk Methods' -> 'Smalltalk/V 286/386'