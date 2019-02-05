adding
addUndeterminateDependentPackage: aPackage from: parent
	^ dependentPackagesDiff
		add:
				((PDDependentPackageItemDiff newWith: aPackage)
						beUnderteminate;
						parent: parent;
						diff: self);
		yourself