*GraphVizExamples
familiesOfSmalltalk

	" GraphViz familiesOfSmalltalk "
	
	| graph |
	graph := self new.
	self configureSmalltalkFamiliesGraph: graph;
		addJavaScriptFamily: graph;
		addDigitalkFamily: graph;
		addSmalltalk: 'Smalltalk' -> 'Smalltalk MT' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Smalltalk/X' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Dolphin' to: graph;
		addSmalltalk: 'Smalltalk' -> 'VisualAge Smalltalk' to: graph;
		addSelfFamily: graph.
	graph
		addLabel: 'Enfin' fillColor: #cornsilk2;
		addLabel: 'ObjectStudio' fillColor: #cornsilk2;
		add: 'Smalltalk' -> 'Enfin' -> 'ObjectStudio'.		
	self	
		addSmalltalk: 'Smalltalk' -> 'Zoku' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Apple Smalltalk' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Berkeley Smalltalk' to: graph;
		addSmalltalk: 'Smalltalk' -> 'DEC VAX/Smalltalk-80 ' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Tektronix Smalltalk' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Ambrai' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Chachara' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Pocket Smalltalk' to: graph;
		addObjectiveCFamilty: graph;
		addSmalltalk: 'Smalltalk' -> 'GNU Smalltalk' to: graph;
		addSmalltalk: 'Smalltalk' -> 'Pocket Smalltalk' -> 'Visual Palmtalk' to: graph;
		addSmalltalk: 'Smalltalk' -> 'GemStone/S' to: graph;
		addJavaFamily: graph;
		addSqueakFamily: graph;
		addSmalltalk: 'Smalltalk' -> 'Strongtalk' to: graph.
	graph
		addLabel: 'F-Script' fillColor: #navajowhite;
		addLabel: 'APL' fillColor: #navajowhite;
		add: 'Smalltalk' -> 'F-Script';
		add: 'APL' -> 'F-Script'.
	self
		addSmalltalk: 'Smalltalk' -> 'SmallScript' to: graph;
		addSmalltalk: 'Smalltalk' -> 'VistaSmalltalk' to: graph;
		addSmalltalk: 'Smalltalk' -> '#Smalltalk' to: graph;
		addVisualWorksFamily: graph;
		addLittleSmalltalkFamily: graph;
		addSmalltalk: 'Smalltalk' -> 'Smalltalk YX' to: graph.
	"self outputFormats do: [ : t | [graph make: t] on: Error do: [ : ex | ] ]."
	graph make: 'svg'.
	graph openInWindow