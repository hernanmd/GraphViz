comparing
= aPDPackageCycle
	(aPDPackageCycle isKindOf: PDPackageCycle) ifFalse: [ ^ false ]. 
	^ self size = aPDPackageCycle size and: [ self packages includesAll: aPDPackageCycle packages ].