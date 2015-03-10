accessing
addLabel: aString fillColor: colorSymbol

	^ self 
		add: aString 
		with: { 
			#style -> #filled . 
			#fillcolor -> colorSymbol . 
			#label -> aString }