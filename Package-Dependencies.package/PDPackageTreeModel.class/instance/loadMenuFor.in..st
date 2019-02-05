actions
loadMenuFor: item in: aMenu
	| menuGroup selected |
	selected := self selectedItemsFromTree.
	menuGroup := MenuGroupModel new.
	self addPackageOptionsFor: selected on: menuGroup.
	self addDependenciesOptionsFor: selected asSet on: menuGroup.
	self addCycleOptionsFor: selected on: menuGroup.
	
	aMenu addMenuGroup: menuGroup.
	^ aMenu