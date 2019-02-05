building
buildTimeline

	graph add: #node with: { #shape -> #plaintext }.
	entries do: [ :each | 
		self graph add: 't' , each uuid asString with: { #label -> each timestamp time asString } ].
	entries allButFirst
		inject: entries first
		into: [ :previous :current |
			self graph add: ('t' , previous uuid asString) -> ('t' , current uuid asString).
			current ].
