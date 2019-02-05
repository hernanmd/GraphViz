private
doWithStopWatch: aBlock modificationTime: originalModTime blockUntilFileUpdated: file waitingNoMoreThan: duration
	| stopwatch returnValue |
	returnValue := aBlock value.
	stopwatch := Stopwatch new.
	stopwatch activate.
	[ stopwatch duration < duration ]
		whileTrue: [ 
			(self modificationTimeOf: file)
				ifNotNilDo: [ :latestModTime | 
					"if file is openable for writing then probably the external process is done"
					"file did not exist before and now exists"
					^ self
						checkExternalProcessValue: returnValue
						modificationTime: originalModTime
						file: file
						latestModificationTime: latestModTime ].
			1000 milliSeconds asDelay wait ].
	self error: 'Timeout expired waiting for ' , file , ' to be updated!'