as yet unclassified
children
	| child |
	child := self isExtensionCheckBoxChecked
		ifFalse: [ self content usersOfPackageWithoutExtensionDependency ]
		ifTrue: [ self content usersOfPackage ].
	^ (child collect: [ :each | each asPackageDependencyWrapper ]) asSortedCollection