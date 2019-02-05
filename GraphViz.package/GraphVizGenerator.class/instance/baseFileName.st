accessing
baseFileName
	" Answer a <String> suitable for file naming (removed file system invalid characters) "
	
	^ self graph name select: [ : each | each isValidFilenameCharacter ]