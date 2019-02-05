adding
addNewPackage: seenPackage
	^ packagesDiff
		add:
			((PDPackageItemDiff newWith: seenPackage)
				beNew;
				diff: self);
		yourself