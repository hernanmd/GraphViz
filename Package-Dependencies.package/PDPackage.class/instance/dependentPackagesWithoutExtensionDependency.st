dependencies
dependentPackagesWithoutExtensionDependency
	^ self dependencies
		inject: Set new
		into: [ :sum :each | 
			each containsOnlyExtensionDependency
				ifFalse: [ 
					sum
						add: each target;
						yourself ]
				ifTrue: [ sum ] ]