accessing
modificationTimeOf: aString
	" #modificationTime answer false OR DateAndTime (???) "

	| answer |

	answer := aString asFileReference ifNotNilDo: [ : entry | entry modificationTime ].
	(answer isKindOf: DateAndTime) ifTrue: [ ^ answer ].
	^ nil.
