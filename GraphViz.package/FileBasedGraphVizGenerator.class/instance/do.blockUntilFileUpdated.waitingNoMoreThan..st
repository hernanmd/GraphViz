private
do: aBlock blockUntilFileUpdated: file waitingNoMoreThan: duration

	| originalModTime |
	originalModTime := self modificationTimeOf: file.
	^ self 
		doWithStopWatch: aBlock
		modificationTime: originalModTime 
		blockUntilFileUpdated: file 
		waitingNoMoreThan: duration
