instance-creation
on: aStream
	^ self new
		initializeFromStream: aStream;
		yourself.