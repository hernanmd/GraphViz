comparing
= anObject
	^self class = anObject class
		and: [ self uid = anObject uid ].