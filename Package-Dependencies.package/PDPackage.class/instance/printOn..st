printing
printOn: aStream
	| numberOfExtension |
	numberOfExtension := self extensionDependenciesSize.
	aStream
		nextPutAll: self packageName;
		nextPutAll: ' --> Dependent packages : ';
		nextPutAll: self dependentPackagesSize asString;
		nextPutAll: ' | Dependencies : ';
		nextPutAll: (self dependenciesSize - numberOfExtension) asString;
		nextPutAll: ' (+ ';
		nextPutAll: numberOfExtension asString;
		nextPutAll: ' extension dependencies)'