creation
createMorph

	^  [
		(PNGReadWriter formFromStream: (self generateType: #png)) first asMorph
		] 
		ensure: [self cleanUpIntermediateFilesAsAppropriate]