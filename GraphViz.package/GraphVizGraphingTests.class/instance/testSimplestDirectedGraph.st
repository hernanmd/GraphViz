testing
testSimplestDirectedGraph

	graph beDirected.
	self should: [graph dot beginsWith: 'digraph {'].
	self should: [graph dot last = $}]