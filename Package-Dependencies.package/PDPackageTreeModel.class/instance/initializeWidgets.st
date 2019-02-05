initialization
initializeWidgets
	tree := self newTree
		multiSelection: true;
		on: $b command do: [ self selectedItemFromTree browseInOtherNautilus ];
		yourself.

	extensionCheckBox := self newCheckBox.
	extensionCheckBox label: 'Show extension dependencies'.
	
	buttonRefresh := self newButton
		icon: (Smalltalk ui icons iconNamed: #refreshIcon);
		help: 'Refresh the TreeModel';
		label: 'Refresh'.
	
	packageTreeNautilus := Nautilus new