actions
buildNodes

	self versions 
		do: [ :version | self graph add: version uid with: { 'label' -> version label } ]
		displayingProgress: 'Writing Nodes'.