testing
testSimplestDirectedGraph
	graph beDirected.
	self assert: (graph dot beginsWith: 'digraph {').
	self assert: graph dot last = $}