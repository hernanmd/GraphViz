generating
writeDotFileNamed: aString

	| fileName file |
	fileName := aString.
	(aString endsWith: self dotExtension) ifFalse: [fileName := fileName, self dotExtension].
	
	file := FileStream forceNewFileNamed: (self outputFileDirectory / fileName) fullName.
	[file nextPutAll: self graph dot] ensure: [file close]