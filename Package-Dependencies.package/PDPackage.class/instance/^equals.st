comparing
= aPackage
	(aPackage isKindOf: PDPackage)
		ifFalse: [ ^ false ].
	^ self packageName = aPackage packageName