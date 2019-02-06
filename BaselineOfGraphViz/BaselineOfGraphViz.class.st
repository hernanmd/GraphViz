Class {
	#name : #BaselineOfGraphViz,
	#superclass : #BaselineOf,
	#category : #BaselineOfGraphViz
}

{ #category : #baselines }
BaselineOfGraphViz >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec
			project: 'XMLParser'
			with: [ 
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #stable;
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
					
			baseline: 'ProcessWrapper' 
			with: [ spec repository: 'github://hernanmd/ProcessWrapper/repository' ].

		spec 
			package: 'GraphViz' 					with: [ spec requires: #('XMLParser' 'CommandShell' ). ];
			package: 'GraphBuilder' 				with: [ spec requires: #('GraphViz' ). ];
			package: #'Package-Dependencies' 	with: [ spec requires: #('GraphViz' ). ].
		spec 
			group: 'Tools' 		with: #('GraphBuilder' #'Package-Dependencies' 'GraphViz' );
			group: 'Core' 		with: #('GraphViz' );
			group: 'default'	with: #('Core') ].
	
]
