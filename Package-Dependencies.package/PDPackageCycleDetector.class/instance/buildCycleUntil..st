actions
buildCycleUntil: children
	| aPackageCycle currentNode |
	aPackageCycle := PDPackageCycle new.
	currentNode := children.
	[ currentNode isNil ]
		whileFalse: [ 
			aPackageCycle addPackage: currentNode.
			currentNode := currentNode bfsParent ].
	(self cycleAlreadyFound: aPackageCycle)
		ifFalse: [ 
			aPackageCycle reversedCycle.
			self addCycle: aPackageCycle ]