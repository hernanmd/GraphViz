private
checkExternalProcessValue: returnValue modificationTime: originalModTime file: file latestModificationTime: latestModTime
	| testfile |
	testfile := FileStream fileNamed: file.	"if file is openable for writing then probably the external process is done"
	^ testfile
		ifNotNil: [ 
			testfile close.
			originalModTime
				ifNil: [ ^ returnValue ]
				ifNotNil: [ 
					latestModTime > originalModTime
						ifTrue: [ ^ returnValue ] ]	"file did not exist before and now exists" ]