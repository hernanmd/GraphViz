accessing
outputPath
	" Answer a <String> specifying the current output path "

	^ outputPath 
		ifNil: [ outputPath := (FileSystem workingDirectory / 'dot') fullName ]
