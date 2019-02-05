queries
systemPackageContaining: aClass
	| info |
	info := (RPackageOrganizer default packageOf: aClass) packageName.
	^ info
		ifNil: [ self error: 'Package for ' , aClass name , ' not found.' ]
		ifNotNil: [ PDPackage on: (RPackageSet named: info asString) ]