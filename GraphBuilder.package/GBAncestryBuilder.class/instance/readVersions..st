building
readVersions: aCollection 

	self repository readableFileNames 
		do: [ : filename | versions add: (GBVersion repository: self repository filename: filename) ]
		displayingProgress: 'Reading Versions'.
	^ versions