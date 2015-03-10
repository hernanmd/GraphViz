testing
testGraphWithSpecificNodeAttributes

	graph add: #A with: {#shape -> #box. #fontname -> #trebuc}.
	self should: [(graph dot lineNumber: 2) includesSubstring:  'shape=box'].
	self should: [(graph dot lineNumber: 2) includesSubstring:  'fontname=trebuc'] 