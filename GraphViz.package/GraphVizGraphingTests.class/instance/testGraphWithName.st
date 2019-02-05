testing
testGraphWithName
	graph name: 'g'.
	self assert: (graph dot beginsWith: 'graph g {').
	self assert: graph dot last = $}