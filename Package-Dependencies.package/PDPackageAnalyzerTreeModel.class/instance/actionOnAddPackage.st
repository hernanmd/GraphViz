protocol
actionOnAddPackage
	self buttonAddPackage action: [ (PDAddPackageModel 
					new 
					packageAnalyzerTreeModel: self)
					open ]