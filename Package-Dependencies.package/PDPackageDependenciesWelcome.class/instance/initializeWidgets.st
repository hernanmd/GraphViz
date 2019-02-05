initialization
initializeWidgets
	self
		initializeLists;
		initializeLabels;
		initializeButtons;
		buildList.
		
	textPackageField := self newTextInput
		ghostText: 'Enter a package name';
		entryCompletion: self packagesEntryCompletion.