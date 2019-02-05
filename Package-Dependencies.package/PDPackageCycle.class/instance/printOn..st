printing
printOn: aStream
	aStream
		nextPutAll: 'A cycle of ';
		print: self size;
		nextPutAll: ' packages : '.
	packages
		do: [ :package | aStream nextPutAll: package packageName ]
		separatedBy: [ aStream space ]