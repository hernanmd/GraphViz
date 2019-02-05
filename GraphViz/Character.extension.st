Extension { #name : #Character }

{ #category : #'*GraphViz' }
Character >> isValidFilenameCharacter [
	" Answer <true> if receiver is safely writable as a FileSystem character "

	^ ((self isSpecial or: [ self isSeparator ]) or: [ self = $: ]) not.
]
