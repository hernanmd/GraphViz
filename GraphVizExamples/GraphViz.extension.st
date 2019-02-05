Extension { #name : #GraphViz }

{ #category : #'*GraphVizExamples' }
GraphViz class >> addDigitalkFamily: graph [
	
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
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addJavaFamily: graph [
	
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
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addJavaScriptFamily: graph [
	
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

]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addLittleSmalltalkFamily: graph [
	
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
		
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addObjectiveCFamilty: graph [

	| famColor |
	
	famColor := #mintcream.
	graph 
		addLabel: 'StepTalk' fillColor: famColor;
		addLabel: 'Objective-C' fillColor: famColor;
		add: 'Smalltalk' -> 'StepTalk';
		add: 'Objective-C' -> 'StepTalk'
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addSOMFamily: graph [
	
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
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addSelfFamily: graph [
	
	| famColor |
	
	famColor := #burlywood.
	graph 
		addLabel: 'Self' fillColor: famColor;
		addLabel: 'CLOS' fillColor: famColor;
		addLabel: 'Slate' fillColor: famColor;
		add: 'Self' -> 'Slate';
		add: 'CLOS' -> 'Slate';
		add: 'Smalltalk' -> 'Slate'.
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addSmalltalk: stAssoc to: graph [
	
	| famColor |
	famColor := #lemonchiffon.
	graph 
		addLabel: stAssoc value fillColor: famColor ;
		add: stAssoc.
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addSqueakFamily: graph [
	
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
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> addVisualWorksFamily: graph [
	
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
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> configureSmalltalkFamiliesGraph: graph [	
	
	graph
		beDirected;
		name: 'FamiliesOfSmalltalk';
		add: #graph with: {
			#labelloc -> 'top' .
			#label -> 'Families of Smalltalk' . 
			#fontsize -> 30 .
			#rankdir -> 'LR'	};
		add: #node with: {
			#fillcolor -> #lightyellow1 . 
			#shape -> #rectangle . 
			#fontsize -> 16}.
]

{ #category : #'*GraphVizExamples' }
GraphViz class >> familiesOfSmalltalk [

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
]
