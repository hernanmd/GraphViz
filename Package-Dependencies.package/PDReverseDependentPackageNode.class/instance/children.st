as yet unclassified
children
	self isExtensionCheckBoxChecked 
			ifFalse: [ ^ self dependenciesToParentNode dependenciesWithoutExtensionDependency ].
	^ self dependenciesToParentNode dependencies