testing
testGraphWithSimpleAttribute
	graph at: #label put: #title.
	self assert: (graph dot lineNumber: 2) = '	label=title;'