building
build: graphName

	self buildGraph: graphName.
	self buildTimeline.
	self buildBrowsing.