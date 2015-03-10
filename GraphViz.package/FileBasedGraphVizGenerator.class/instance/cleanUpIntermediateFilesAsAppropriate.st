private
cleanUpIntermediateFilesAsAppropriate
	" needsWork "

	| entries |
	deleteIntermediateFiles ifFalse: [^ self].
	
"	(self outputFileDirectory / self dotFileName) asFileReference ensureDeleted.
	
	entries := self outputFileDirectory matchingEntries: (self baseFileName, '.*').
	entries do: [:each | self outputFileDirectory deleteFileNamed: each name]"