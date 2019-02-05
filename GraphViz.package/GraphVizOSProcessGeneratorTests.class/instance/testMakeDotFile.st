testing
testMakeDotFile

	| gv fileName fs |

	gv := self exampleHistoryOfSmalltalk.
	fileName := gv generator outputFileNameFor: #plain.
	fileName asFileReference ensureDelete.
	gv make: #plain.
	fs := FileStream fileNamed: fileName.
	[ self assert: ((fs contents last: 20) copyWithoutAll: (String cr, String lf)) = '58 solid blackstop' ]
	ensure: [ 
		fs close.
		fileName asFileReference ensureDelete ]
