world menu
menuCommandOn: aBuilder
	<worldMenu>

	(aBuilder item: #PackageDependencies)
		order: 0.21;
		parent: #Tools;
		label: 'Package Dependencies Browser';
		icon: (Smalltalk ui icons iconNamed: #packageIcon);
		action: [ PDPackageDependenciesWelcome new open ]