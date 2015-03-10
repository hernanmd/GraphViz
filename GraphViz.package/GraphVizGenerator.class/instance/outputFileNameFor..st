accessing
outputFileNameFor: extension
	" Answer a <String> with receiver's output graph path "

	^ (self outputFileDirectory / (self baseFileName, '.', extension)) fullName 