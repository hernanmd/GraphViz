testing
testGraphToMorph

	graph add: #A.
	
	self should: [graph asMorph height > 0]