adding
addNewDependentPackage: package from: parent
	^ dependentPackagesDiff
		add:
			((PDDependentPackageItemDiff
				newWith: package)
				beNew;
				parent: parent;
				diff: self);
		yourself