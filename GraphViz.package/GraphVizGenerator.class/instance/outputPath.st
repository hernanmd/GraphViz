accessing
outputPath

	^ outputPath 
		ifNil: [ (FileSystem workingDirectory / 'dot') fullName ]
