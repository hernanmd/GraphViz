accessing
outputFileDirectory

	| fileRef |
	(fileRef := self outputPath asFileReference ensureCreateDirectory) exists
		ifFalse: [ self error: 'Output directory could not be created!' ].
	^ fileRef
