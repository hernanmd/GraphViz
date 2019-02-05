accessing
modificationTimeOf: aString
	" #modificationTime answer false OR DateAndTime (???) "

	| answer |

	answer := aString asFileReference ifNotNilDo: [ : entry | 
		[ entry modificationTime ]
		on: FileDoesNotExist 
		do: [ : ex | nil ] ].
	(answer isKindOf: DateAndTime) ifTrue: [ ^ answer ].
	^ nil.
