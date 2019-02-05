initialization
initializeButtons
	buttonOpen := self newButton
		help: 'Open the package dependencies analysis';
		label: 'Browse dependencies';
		icon: (Smalltalk ui icons iconNamed: #packageIcon).
	buttonAddPackage := self newButton
		help: 'Add package to browse';
		label: 'Add package';
		icon: (Smalltalk ui icons iconNamed: #addIcon).
	buttonRemovePackage := self newButton
		help: 'Remove package to browse';
		label: 'Remove package';
		icon: (Smalltalk ui icons iconNamed: #removeIcon).
	buttonRemoveAll := self newButton
		help: 'Remove all selected packages';
		label: 'Remove all'.
	buttonAddAll := self newButton
		help: 'Add all packages';
		label: 'Add all'