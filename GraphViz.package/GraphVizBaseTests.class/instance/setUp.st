accessing
setUp

	tempDir := 	FileSystem workingDirectory / 'graphVizTestTemp'.
	tempDir ensureCreateDirectory.
	graph := GraphViz new.
	(graph generator outputPath: tempDir fullName) makeNoWait: #'plain-ext'.
	"fileReference := tempDir / (graphTest name, '.plain-ext')."