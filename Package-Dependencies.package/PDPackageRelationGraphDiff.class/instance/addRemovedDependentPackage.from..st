adding
addRemovedDependentPackage: package from: parent
	^ dependentPackagesDiff
		add:
			((PDDependentPackageItemDiff
				newWith: package)
				beRemoved;
				parent: parent;
				diff: self);
		yourself