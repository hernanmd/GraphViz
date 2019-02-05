streaming
writeHeaderOn: stream withIndent: aNumber

	directed ifTrue: [ stream nextPutAll: 'di' ].
	stream
		nextPutAll: self nodeType;
		nextPut: Character space.
		
	self id ifNotNil: [ : name | stream nextPutAll: self safeId; nextPut: $ ].
	stream nextPutAll: '{'.