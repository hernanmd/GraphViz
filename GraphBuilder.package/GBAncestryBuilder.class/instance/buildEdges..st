building
buildEdges: aCollection 

	versions
		do: [ :version |
				version setAncestors: Set new.
				version info ancestors do: [ :ancestor |
					(versions like: (GBVersion info: ancestor))
						ifNotNilDo: [ :each | version ancestors add: each ] ].
				version setDependencies: Set new.
				version version ifNotNilDo: [ :ver |
					ver dependencies do: [ :dependency |
						(versions like: (GBVersion info: dependency versionInfo))
							ifNotNilDo: [ :each | version dependencies add: each ] ] ] ]
		displayingProgress: 'Building Edges'.