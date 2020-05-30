Extension { #name : #GraphViz }

{ #category : #'*GraphViz-Examples' }
GraphViz class >> createAllOutputFiles [
	"Generate all the output formats listed in GraphViz documentation (as of dot version 2.2).
	Results are files named 'directedGraphSample.*' in the 'dot' folder."

	"GraphViz createAllOutputFiles"

	self new
		beDirected;
		name: #directedGraphSample;
		add: #graph with: {#ratio -> '0.5'};
		add: #node with: {#fontsize -> 10};	
		add: #Smalltalk -> #Squeak;
		add: #Smalltalk -> 'C++';
		add: 'C++' -> #Java;
		add: #Java -> 'C#';
		
		makeAll

]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> createAllOutputFormats [
	"Generate all the output formats listed in GraphViz documentation (as of dot version 2.2)."

	"GraphViz createAllOutputFormats"

	| d viz |
	d := Dictionary new.
	viz := self new
		beDirected;
		name: #directedGraphSample1;
		add: #graph with: {#ratio -> '0.5'};
		add: #node with: {#fontsize -> 10};	
		add: #Smalltalk -> #Squeak;
		add: #Smalltalk -> 'C++';
		add: 'C++' -> #Java;
		add: #Java -> 'C#';
		yourself.
	self outputFormats do: [:t | d at: t put: (viz asOutputType: t)].
	^ d
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> directedGraphSample [

	"GraphViz directedGraphSample"
	| graph |
	graph := self new.

	graph beDirected.
	graph
		name: #directedGraphSample;
		add: #node with: {#fontsize -> 28};
		
		subgraph: #clusterfoo do:
			[graph
				at: #style put: #filled;
				at: #fillcolor put: #lightgrey;
				add: #A -> #B;
				at: #label put: #Foo].
		
	graph
		add: #A -> #J;
		add: #B -> #Z;
		
		add: #graph with: {#label -> 'Cluster Graph'. #fontsize -> 50};
		
		openInWindow
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> exampleCreateAllOutputFiles [
	"
	Generate all the output formats listed in GraphViz documentation (as of dot version 2.2).
	Results are files named 'directedGraphSample.*' in the 'dot' folder.
	"

	self new
		beDirected;
		name: #exampleDirectedGraph;
		add: #graph with: {#ratio -> '0.5'};
		add: #node with: {#fontsize -> 10};	
		add: #Smalltalk -> #Squeak;
		add: #Smalltalk -> 'C++';
		add: 'C++' -> #Java;
		add: #Java -> 'C#';
		
		makeAll

]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> exampleCreateAllOutputFormats [
	"Generate all the output formats listed in GraphViz documentation (as of dot version 2.2)."

	| d viz |
	d := Dictionary new.
	viz := self new
		beDirected;
		name: #directedGraphSample1;
		add: #graph with: {#ratio -> '0.5'};
		add: #node with: {#fontsize -> 10};	
		add: #Smalltalk -> #Squeak;
		add: #Smalltalk -> 'C++';
		add: 'C++' -> #Java;
		add: #Java -> 'C#';
		yourself.
	self outputFormats do: [:t | d at: t put: (viz asOutputType: t)].
	^ d
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> exampleDirectedGraph [
	" 
	GraphViz exampleDirectedGraph 
	"
	| graph |
	graph := self new.

	graph beDirected.
	graph
		name: #directedGraphSample;
		add: #node with: {#fontsize -> 28};
		
		subgraph: #clusterfoo do:
			[graph
				at: #style put: #filled;
				at: #fillcolor put: #lightgrey;
				add: #A -> #B;
				at: #label put: #Foo].
		
	graph
		add: #A -> #J;
		add: #B -> #Z;
		
		add: #graph with: {#label -> 'Cluster Graph'. #fontsize -> 50};
		
		openInWindow
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> exampleHistoryOfSmalltalk [

	| graph |
	graph := self new.
	graph
		beDirected;
		name: 'HistoryOfSmalltalk';
		add: #graph with: {#overlap -> #scale. #concentrate -> #true. #ranksep -> 0.25};
		add: #edge with: {#arrowsize -> 0.5};
		
		add: #node with: {
			#shape -> #plaintext . 
			#fontsize -> 16 };
			
		add: #past ->  '1970s' -> 1980 -> 1983 -> 1985 -> 1991 -> 1993 -> 1995 -> 1996 -> 1998 -> 1999 -> 2000;
		
		add: #node with: {
			#shape -> #box . 
			#fontsize -> 12 . 
			#style -> #filled . 
			#fillcolor -> #bisque3 . 
			#height -> 0.25};
	
		rank: #past add: #(CDL Simula Lisp);
		rank: '1970s' add: #('Smalltalk-71' 'Smalltalk-72, 74, 76, 78');
		rank: 1980 add: 'Smalltalk-80';
		rank: 1983 add: 'Objective-C';
		rank: 1985 add: #Self;
		rank: 1991 add: #Oak;
		rank: 1993 add: #Ruby;
		rank: 1995 add: 'Java 1';
		rank: 1996 add: #Squeak;
		rank: 1998 add: 'Java 2';
		rank: 1999 add: #VisualWorks;
		rank: 2000 add: 'C#';
		
		add: #Simula -> 'Smalltalk-71';
		add: #CDL -> 'Smalltalk-71';
		add: #Lisp -> 'Smalltalk-71' -> 'Smalltalk-72, 74, 76, 78' -> 'Smalltalk-80' -> 'Objective-C' -> #Oak;
		add: 'Smalltalk-80' -> #Self;
		add: 'Smalltalk-80' -> #Oak -> 'Java 1' -> 'Java 2' ->  'C#';
		add: 'Smalltalk-80' -> #Ruby;
		add: 'Smalltalk-80' -> #Squeak;
		add: 'Smalltalk-80' -> #VisualWorks;
		
		openInWindow
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> exampleUndirectedGraph [
	"
	GraphViz exampleUndirectedGraph 
	"
	
	| graph |
	graph := self new.
	graph
		name: #undirectedGraphSample;
		add: #graph with: #start -> #rand;
		add: #node with: {#fontsize -> 28};
		
		add: #A -> #X;
		
		add: #node with: #shape -> #box;
		
		add: #J with: {#style -> #filled. #fillcolor -> #red. #label -> 'J\nRed'};
		add: #A -> #J;
		add: #A -> #Z;
		
		add: #graph with: {#label -> 'Test Graph'. #fontsize -> 50};
		
		openInWindow
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> exampleUsersOfCollections [

	self usersOf: #Bag.
	self usersOf: #WeakRegistry.


]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> historyOfSmalltalk [

	"GraphViz historyOfSmalltalk"
	| graph |
	graph := self new.
	
	graph
		beDirected;
		name: 'HistoryOfSmalltalk';
		add: #graph with: {#overlap -> #scale. #concentrate -> #true. #ranksep -> 0.25};
		add: #edge with: {#arrowsize -> 0.5};
		
		add: #node with: {#shape -> #plaintext. #fontsize -> 16};
		add: #past ->  '1970s' -> 1980 -> 1983 -> 1985 -> 1991 -> 1993 -> 1995 -> 1996 -> 1998 -> 1999 -> 2000;
		
		add: #node with: {#shape -> #box. #fontsize -> 12. #style -> #filled. #fillcolor -> #ivory. #height -> 0.25};
	
		rank: #past add: #(CDL Simula Lisp);
		rank: '1970s' add: #('Smalltalk-71' 'Smalltalk-72, 74, 76, 78');
		rank: 1980 add: 'Smalltalk-80';
		rank: 1983 add: 'Objective-C';
		rank: 1985 add: #Self;
		rank: 1991 add: #Oak;
		rank: 1993 add: #Ruby;
		rank: 1995 add: 'Java 1';
		rank: 1996 add: #Squeak;
		rank: 1998 add: 'Java 2';
		rank: 1999 add: #VisualWorks;
		rank: 2000 add: 'C#';
		
		add: #Simula -> 'Smalltalk-71';
		add: #CDL -> 'Smalltalk-71';
		add: #Lisp -> 'Smalltalk-71' -> 'Smalltalk-72, 74, 76, 78' -> 'Smalltalk-80' -> 'Objective-C' -> #Oak;
		add: 'Smalltalk-80' -> #Self;
		add: 'Smalltalk-80' -> #Oak -> 'Java 1' -> 'Java 2' ->  'C#';
		add: 'Smalltalk-80' -> #Ruby;
		add: 'Smalltalk-80' -> #Squeak;
		add: 'Smalltalk-80' -> #VisualWorks;
		
		openInWindow
]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> makeLayoutCoordinates [
	"Answer plain text layout coordinates in a format that could be parsed in Squeak."

	"GraphViz makeLayoutCoordinates explore"

	^ self new
		beDirected;
		name: #directedGraphSample1;
		add: #graph with: {#ratio -> '0.5'};
		add: #node with: {#fontsize -> 10};	
		add: #Smalltalk -> #Squeak;
		add: #Smalltalk -> 'C++';
		add: 'C++' -> #Java;
		add: #Java -> 'C#';
		asLayoutCoordinates

]

{ #category : #'*GraphViz-Examples' }
GraphViz class >> undirectedGraphSample [

	"GraphViz undirectedGraphSample"
	| graph |
	graph := self new.

	graph
		name: #undirectedGraphSample;
		add: #graph with: #start -> #rand;
		add: #node with: {#fontsize -> 28};
		
		add: #A -> #X;
		
		add: #node with: #shape -> #box;
		
		add: #J with: {#style -> #filled. #fillcolor -> #red. #label -> 'J\nRed'};
		add: #A -> #J;
		add: #A -> #Z;
		
		add: #graph with: {#label -> 'Test Graph'. #fontsize -> 50};
		
		openInWindow
]
