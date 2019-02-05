building
buildBrowsing

	graph add: #node with: { #shape -> #box }.
	entries do: [ :each |
		graph add: #node with: { #label -> each type }.
		self graph rank: 't' , each uuid asString add: 'n' , each uuid asString ].
	entries do: [ :each |
		continuation at: each previousCC ifPresent: [ :previous |
			self graph add: ('n' , previous uuid asString) -> ('n' , each uuid asString) ] ].