testing
testGraphWithSpecificNodeAttribute
	graph add: #A with: #shape -> #box.
	self assert: (graph dot lineNumber: 2) equals: '	A [shape=box];'