instance creation
repository: aRepository filename: aFilename
	
	^ self version: (aRepository versionFromFileNamed: aFilename)
"	^ [ self version: (aRepository versionFromFileNamed: aFilename) ]
	on: MCRepositoryError, ZnHttpUnsuccessful
	do: [ : ex | self halt. ]"