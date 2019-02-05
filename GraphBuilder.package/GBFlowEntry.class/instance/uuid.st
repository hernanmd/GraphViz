accessing
uuid
	^ timestamp julianDayNumber * NanosInSecond * SecondsInDay 
		+ timestamp asNanoSeconds 
		+ self identityHash.