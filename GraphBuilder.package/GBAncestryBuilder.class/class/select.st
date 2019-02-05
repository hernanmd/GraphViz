instance creation
select
	|  repo types index |
	
	types := MCRepositoryGroup default repositories.
	index := UIManager default 
					chooseFrom: (types collect: [ : ea | ea description ])
					title: 'Choose Repository'.
	(repo := index = 0 ifFalse: [ types at: index ]) notNil 
		ifTrue: [ ^ ((self on: repo) build: repo description) asOutputType: #png ]