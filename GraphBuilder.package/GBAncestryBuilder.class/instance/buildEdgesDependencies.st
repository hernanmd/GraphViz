actions
buildEdgesDependencies

	| roots ranked |

	roots := self versions copy.
	ranked := Set new.
	self versions 
		do: [ : version |
			version dependencies do: [ :each |
				roots remove: each ifAbsent: nil ] ]
		displayingProgress: 'Searching Dependency Root'.

	roots asSortedCollection 
		do: [ :root |
			root deep in: [ :dependencies |
				dependencies size > 1 ifTrue: [
					self graph
						rank: root uid
						add: (Array streamContents: [ :stream |
							dependencies do: [ :each | 
								(ranked includes: each) ifFalse: [
									stream nextPut: each uid.
									ranked add: each ] ] ]) ] ] ]
		displayingProgress: 'Writing Dependency Edges'.