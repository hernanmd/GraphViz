as yet unclassified
usersOfWithoutExtensionDependency: aPackage
	| users |
	users := OrderedCollection new.
	self seenPackages do: [ :package |
			(package dependentPackagesWithoutExtensionDependency includes: aPackage) ifTrue: [ 
				users add: package.
				 ]
		].
	^ users.