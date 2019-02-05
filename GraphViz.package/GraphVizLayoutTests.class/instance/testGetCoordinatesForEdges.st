testing
testGetCoordinatesForEdges
	| edge |
	edge := graph add: #A -> #B.
	graph doLayout.
	self assert: edge vertices size equals: 4.
	self assert: edge vertices first isPoint.
	self assert: edge vertices first x > 0.
	self assert: edge vertices first y > 0