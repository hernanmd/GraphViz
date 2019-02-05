testing
testGraphWithSpecificNodeAttributes
	graph
		add: #A
		with:
			{(#shape -> #box).
			(#fontname -> #trebuc)}.
	self
		assert: ((graph dot lineNumber: 2) includesSubstring: 'shape=box').
	self
		assert: ((graph dot lineNumber: 2) includesSubstring: 'fontname=trebuc')