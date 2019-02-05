procotol
nodeForDependency: anItem
	anItem isExtensionDependency
		ifTrue: [ ^ PDExtensionDependencyNode ].
	anItem isReferenceDependency
		ifTrue: [ ^ PDReferenceDependencyNode ].
	anItem isInheritanceDependency
		ifTrue: [ ^ PDInheritanceDependencyNode ].
	^ PDTraitDependencyNode