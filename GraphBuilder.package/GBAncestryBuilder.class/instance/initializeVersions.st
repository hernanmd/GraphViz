private
initializeVersions

	versions := Set new.
	self readVersions: versions.
	self buildNodes: versions.
	self buildEdges: versions.