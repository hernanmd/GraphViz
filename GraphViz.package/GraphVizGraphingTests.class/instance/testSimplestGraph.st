testing
testSimplestGraph
	self assert: (graph dot beginsWith: 'graph {').
	self should: [ graph dot last = $} ]