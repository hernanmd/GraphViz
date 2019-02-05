actions
addCycleOptionsFor: selected on: menuGroup
	| cycleNodeSelected cycle graphvizGenerator |
	cycleNodeSelected := selected first.
	cycleNodeSelected isCycleNode
		ifTrue: [ 
			menuGroup
				addMenuItem:
					(MenuItemModel new
						name: 'Generate GraphViz file';
						action: [ 
									self ifGraphVizAbsent: [ self error: 'Please install Graphviz Support' ].
									cycle := cycleNodeSelected content.
									graphvizGenerator := PDPackageCycleGenerator newWith: cycle named: 'CycleGraph' , cycle size asString , 'nodes'.
									self saveGraphAndOpenWith: graphvizGenerator.
									 ]) ]