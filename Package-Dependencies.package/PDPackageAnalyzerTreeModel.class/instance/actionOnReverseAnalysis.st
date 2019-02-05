protocol
actionOnReverseAnalysis
	buttonReverseAnalysis action: [ 
		(PDPackageAnalyzerWindowPackageDependencies new 
						initializeWithRelationGraph: self relationGraph) 
					open ]