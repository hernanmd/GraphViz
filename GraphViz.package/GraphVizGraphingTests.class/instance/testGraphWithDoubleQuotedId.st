testing
testGraphWithDoubleQuotedId
	graph add: 'HI THERE'.
	self assert: (graph dot lineNumber: 2) = '	"HI THERE";'