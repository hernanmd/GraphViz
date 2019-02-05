accessing
hasConnectorsInstalled

	^ RPackageOrganizer default packages anySatisfy: [:each | each packageName = #Connectors]