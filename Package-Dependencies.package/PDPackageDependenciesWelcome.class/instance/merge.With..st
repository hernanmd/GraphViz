as yet unclassified
merge: aCollection With: anOtherCollection
	| merge |
	merge := Set new.
	aCollection do: [ :each | merge add: each ].
	anOtherCollection do: [ :each | merge add: each ].
	^ merge