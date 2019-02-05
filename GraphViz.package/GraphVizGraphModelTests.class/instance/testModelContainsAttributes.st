testing
testModelContainsAttributes
	graph addAttribute: #A -> #B.
	self assert: graph attributes size equals: 1.
	self assert: graph attributes first key equals: #A.
	self assert: graph attributes first value equals: #B