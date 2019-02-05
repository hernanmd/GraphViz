building
buildNodes: aCollection 

	versions copy 
		do: [ : version |
				versions addAll: 
					(version info allAncestors collect: [ :ancestor | GBVersion info: ancestor ]) ]
		displayingProgress: 'Building Nodes'.
