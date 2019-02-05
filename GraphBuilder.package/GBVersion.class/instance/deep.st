accessing-dynamic
deep
	^Array streamContents: [ :stream |
		self dependencies do: [ :each |
			stream nextPut: each.
			stream nextPutAll: each deep ] ].