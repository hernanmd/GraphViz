private
loadFrom: aSerializeFile with: newRelationGraph
	^ (PDPackageRelationGraphDiff new)
		oldRelationGraph: (FLMaterializer materializationFromFileNamed: aSerializeFile);
		newRelationGraph: newRelationGraph