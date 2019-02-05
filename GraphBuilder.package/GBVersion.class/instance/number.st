accessing-dynamic
number
	| number |
	number := self info name copyAfterLast: $..
	^ (number notEmpty and: [ number isAllDigits ])
		ifTrue: [ number asNumber ]
		ifFalse: [ 0 ].