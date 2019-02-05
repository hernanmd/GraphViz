dependencies
dependentPackages
	^ self dependencies 
			inject: Set new 
			into: [ :sum :each | sum add: each target; yourself ].