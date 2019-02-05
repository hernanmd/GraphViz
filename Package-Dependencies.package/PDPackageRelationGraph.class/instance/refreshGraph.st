updating
refreshGraph
	| olderPackages refreshPackage |
	classToPackage := IdentityDictionary new.
	olderPackages := self seenPackagesName.
	self clearPackages.
	olderPackages
		do: [ :packageName | 
			refreshPackage := self pDPackagewith: packageName.
			self addPackage: refreshPackage ].
	self build