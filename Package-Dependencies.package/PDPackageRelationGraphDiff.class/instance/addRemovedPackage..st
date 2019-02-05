adding
addRemovedPackage: seenPackage
	^ packagesDiff
		add:
			((PDPackageItemDiff newWith: seenPackage)
				beRemoved;
				diff: self);
		yourself