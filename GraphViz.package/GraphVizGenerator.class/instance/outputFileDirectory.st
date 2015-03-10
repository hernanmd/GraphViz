accessing
outputFileDirectory

	| fileRef |
	fileRef := self outputPath asFileReference.
	fileRef ensureCreateDirectory.
	^ fileRef
