*GraphVizExamples
addSmalltalk: stAssoc to: graph
	
	| famColor |
	famColor := #lemonchiffon.
	graph 
		addLabel: stAssoc value fillColor: famColor ;
		add: stAssoc.