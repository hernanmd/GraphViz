actions
treeWhenBuiltDo
	self tree
		whenBuiltDo: [ 
			tree
				rootNodeHolder: [ :item | 
					PDPackageNode new
						content: item;
						treeModelParent: self;
						packageTreeNautilus: self packageTreeNautilus;
						packageTreeNautilusUI: self packageTreeNautilusUI;
						cycle: false ] ]