build items
buildEdges
	relationGraph packages
		do: [ :package | 
			package dependencies
				do: [ :dependency | 
					graphviz
						add: dependency source packageName -> dependency target packageName
						with: {(#label -> dependency mySize)} ] ]
		displayingProgress: 'Building edges'