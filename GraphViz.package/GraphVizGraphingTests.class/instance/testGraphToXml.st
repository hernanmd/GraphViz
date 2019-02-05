testing
testGraphToXml
	graph add: #A.
	graph add: #B -> #C.
	self
		should: [ Smalltalk globals includesKey: #XMLDOMParser ]
		description: 'Need YAXO package to run this test and use asXml feature of graphs'.
	self assert: graph asXml topElement localName equals: #gxl