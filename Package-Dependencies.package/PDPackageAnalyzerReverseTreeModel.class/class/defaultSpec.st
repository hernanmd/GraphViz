specs
defaultSpec
	<spec: #default>
	^ SpecLayout composed
		newColumn:
			[ :col | 
			col
				newRow: [ :row | row add: #buttonRefresh ] height: 30;
				newRow: [ :row | 
							row
								add: #packageLabel;
								add: #extensionCheckBox ]
					height: 30;
				add: #tree ] yourself