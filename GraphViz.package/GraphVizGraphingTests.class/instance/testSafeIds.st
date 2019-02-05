testing
testSafeIds
	self assert: (graph safeIdFor: #A) equals: #A.
	self assert: (graph safeIdFor: 10) equals: '10'.
	self assert: (graph safeIdFor: '"10"') equals: '"10"'.
	self
		assert: (graph safeIdFor: '<TABLE> </TABLE>')
		equals: '<TABLE> </TABLE>'.
	self assert: (graph safeIdFor: '10ABC') equals: '"10ABC"'.
	self assert: (graph safeIdFor: 'ABC DEF') equals: '"ABC DEF"'.
	self assert: (graph safeIdFor: 'ABC-DEF') equals: '"ABC-DEF"'