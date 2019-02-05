protocol
actionOnFindCycles
	| selectedPackages selectedItems |
	selectedItems := self selectedItemsFromTree.
	^ (self arePackageNodes: selectedItems)
		ifTrue: [ 
			self notify: 'This could be a while, confirm?'.
			selectedPackages := self pdPackagesFrom: selectedItems.
			systemCycles ifNil: [ systemCycles := PDPackageAnalyzerWindowCycleDetection  system ].
			systemCycles
				updateWithFilter: selectedPackages;
				open ]