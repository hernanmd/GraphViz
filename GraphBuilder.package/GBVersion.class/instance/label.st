accessing-dynamic
label
	" Private - Build node contents "
	
	^ String streamContents: [ : stream |
		stream 
			nextPutAll: self date;
			nextPut: $|;
			nextPutAll: self package; 
			nextPut: $|;
			nextPutAll: self author; 
			nextPut: $|;
			nextPutAll: self number asString ].