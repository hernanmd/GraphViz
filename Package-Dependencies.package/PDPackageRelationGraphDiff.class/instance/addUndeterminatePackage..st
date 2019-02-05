adding
addUndeterminatePackage: aPackage
	^ packagesDiff
		add:
			((PDPackageItemDiff newWith: aPackage)
				beUnderteminate;
				diff: self);
				yourself