accessing
children
	| child |
	child := self rootNode isCycle
		ifTrue: [ self rootNode content dependentPackagesFrom: self content ]
		ifFalse: [ 
			self isExtensionCheckBoxChecked
				ifFalse: [ self content dependentPackagesWithoutExtensionDependency ]
				ifTrue: [ self content dependentPackages ] ].
	^ (child collect: [ :package | package asPackageDependencyWrapper ]) asSortedCollection