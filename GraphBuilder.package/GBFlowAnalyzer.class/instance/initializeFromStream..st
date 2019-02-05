initialize-release
initializeFromStream: aStream
	[ aStream atEnd ] whileFalse: [ 
		self add: (GBFlowEntry 
			fromString: (aStream 
				upTo: Character lf)) ].