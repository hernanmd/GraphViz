private
treeWhenBuiltDo	
	self tree
		whenBuiltDo: [ 
			tree
				rootNodeHolder: [ :item | 
					PDReversePackageNode new
						content: item;
						treeModelParent: self;
						packageTreeNautilus: self packageTreeNautilus;
						packageTreeNautilusUI: self packageTreeNautilusUI;
						cycle: false ] ]
	