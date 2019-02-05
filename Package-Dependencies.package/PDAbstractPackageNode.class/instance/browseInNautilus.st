browse-nautilus
browseInNautilus
	| packageToBrowse |
	packageToBrowse := self content rPackageSet.
	
	self browsePackageInNautilus: packageToBrowse.