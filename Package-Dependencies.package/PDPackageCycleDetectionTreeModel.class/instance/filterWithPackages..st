as yet unclassified
filterWithPackages: aCollectionOfPDPackage
	filter := aCollectionOfPDPackage.
	self cycles: (self analysis cyclesWithAtLeast: filter)