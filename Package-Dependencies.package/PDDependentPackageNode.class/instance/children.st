accessing
children
	| aCompositeDependency |
	aCompositeDependency := self compositeDependencyTo.
	self isExtensionCheckBoxChecked 
	ifFalse: [ ^ aCompositeDependency dependenciesWithoutExtensionDependency ].
	^ aCompositeDependency dependencies