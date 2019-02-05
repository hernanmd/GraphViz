comparing
<= anObject

	self package < anObject package
		ifTrue: [ ^true ].
	self package = anObject package
		ifTrue: [ ^self number asNumber > anObject number asNumber ].
	^false.