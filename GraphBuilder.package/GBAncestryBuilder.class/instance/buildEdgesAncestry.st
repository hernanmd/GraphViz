actions
buildEdgesAncestry
	self versions 
		do: [ :version |
			version ancestors do: [ :ancestor |
				self graph 
					add: ancestor uid -> version uid
					with: { } ] ]
		displayingProgress: 'Writing Ancestry Edges'.