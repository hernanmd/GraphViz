testing
testObjectsHaveAttributes
	graph add: #A with: #label -> 'A label'.
	self assert: graph nodes first attributes size equals: 1.
	self assert: (graph nodes first attributes at: #label) = 'A label'.
	graph
		add: #B
		with:
			{(#foo -> #bar).
			(#doo -> #boo)}.
	self assert: graph nodes second attributes size equals: 2