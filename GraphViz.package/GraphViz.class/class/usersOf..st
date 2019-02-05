examples
usersOf: aSymbol
	" GraphViz usersOf: #WeakRegistry "
	" GraphViz usersOf: #Bag "
	
	| graph  |
	graph := self new.
	graph
		name: (#usersOf, aSymbol) capitalized;
		add: #graph 		with: {
				#overlap -> #box . 
				#start -> #rand . 
				#splines -> #true 
				};
		add: #node 		with: { 
				#fontsize -> 10 . 
				#height -> 0.25 . 
				#shape -> #box . 
				#style -> #filled . 
				#fillcolor -> #khaki 
				};
		add: aSymbol 	with: {#fillcolor -> #palegreen};
		add: #edge 		with: {#len -> 0.75}.
		
	(Smalltalk at: aSymbol) allCallsOn do: 
		[ : each |
			graph
				add: (each className, '>>', each selector) 
				with: #label -> (each className, '>>\n', each selector).
			graph 
				add: aSymbol -> (each className, '>>', each selector)
				with: {#arrowtail -> #normal. #arrowsize -> 0.5} ].

	graph
		add: #graph with: {#label -> ('Users of ', aSymbol). #fontsize -> 20};
		
		openInWindow