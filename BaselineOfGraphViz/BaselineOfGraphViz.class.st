Class {
	#name : #BaselineOfGraphViz,
	#superclass : #BaselineOf,
	#category : #BaselineOfGraphViz
}

{ #category : #baselines }
BaselineOfGraphViz >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		self baselineOSDeps: spec.
		self baselinePackages: spec.
		self baselineGroups: spec ].
	
	self baselinePharo: spec.
	
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineAllGroup: spec [

	spec
		group: 'All'
		with: #(
			'Core' 
			'Tests'
			'Builder'
			'Examples'
			'PackageDependencies')
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineBasicGroup: spec [

	spec
		group: 'Basic'
		with: #(
			'GraphViz' 
			'GraphViz-Generators')
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineCoreGroup: spec [

	spec 
		group: 'Core' 
		with: #(
			'Basic'
			'GraphViz'
			'GraphViz-Generators')
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineExamplesGroup: spec [

	spec
		group: 'Examples'
		with: #('GraphViz' 'GraphVizExamples')
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineGraphBuilderGroup: spec [

	spec
		group: 'Builder'
		with: #('GraphViz' 'GraphBuilder')
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineGroups: spec [

	self baselineCoreGroup: spec.
	self baselineBasicGroup: spec.
	self baselineGraphBuilderGroup: spec.
	self baselineExamplesGroup: spec.
	self baselinePackageDependenciesGroup: spec.
	self baselineTestsGroup: spec.
	self baselineAllGroup: spec.
	spec group: 'default'	with: #('Core') 
]

{ #category : #baselines }
BaselineOfGraphViz >> baselineOSDeps: spec [

	spec
		for: #(Unix MacOS)
		do: [
			self specForOsSubprocess: spec.
			spec package: 'GraphViz-Generators-OSSubProcess' with: [ spec requires: #('OSSubprocess') ] ].

	spec
		for: #Windows
		do: [ 
			self specForProcessWrapper: spec.
			spec package: 'GraphViz-Generators-FileBased' with: [ spec requires: #('ProcessWrapper') ] ].
]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselinePackageDependenciesGroup: spec [

	spec
		group: 'PackageDependencies'
		with: #(
			'GraphViz'
			'Package-Dependencies')
]

{ #category : #baselines }
BaselineOfGraphViz >> baselinePackages: spec [

	spec 
		package: 'GraphViz' 									with: [ spec requires: #('XMLParser'). ];
		package: 'GraphBuilder' 								with: [ spec requires: #('GraphViz' ) ];
		package: 'GraphViz-Generators'						with: [ spec requires: #('GraphViz' ) ];
		package: 'GraphViz-Generators-OSSubProcess' 		with: [ spec requires: #('GraphViz-Generators') ];
		package: 'GraphViz-Generators-FileBased'			with: [ spec requires: #('GraphViz-Generators' ) ];
		package: 'GraphViz-Generators-OSProcess' 		with: [ spec requires: #('GraphViz-Generators-FileBased' ) ];
		package: 'GraphViz-Tests' 							with: [ spec requires: #('GraphViz-Generators' ) ];
		package: 'GraphBuilder' 								with: [ spec requires: #('GraphViz' ) ];
		package: 'Package-Dependencies' 					with: [ spec requires: #('GraphViz' ) ].
]

{ #category : #baselines }
BaselineOfGraphViz >> baselinePharo: spec [

	spec for: #(#'pharo4.x' #'pharo5.x' #'pharo6.x' #'pharo7.x') do: [ 
		self specForXMLParserPharo7: spec.
		spec 
			package: 'GraphViz'	with: [ spec includes: #('GraphViz-Generators-OSProcess') ];
			group: 'Basic' 			with: #('GraphViz')  ].

	spec for: #'pharo8.x' do: [ 
		self specForXMLParserPharo8: spec.
		spec 
			package: 'GraphViz'	with: [ spec includes: #('GraphViz-Generators-OSSubProcess') ];
			group: 'Basic' 			with: #('GraphViz') ].

]

{ #category : #'baseline-groups' }
BaselineOfGraphViz >> baselineTestsGroup: spec [

	spec
		group: 'Tests'
		with: #('GraphViz' 'GraphViz-Tests')
]

{ #category : #baselines }
BaselineOfGraphViz >> specForOsSubprocess: spec [

	spec 
		baseline: 'OSSubprocess' 
		with: [ spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ]
]

{ #category : #baselines }
BaselineOfGraphViz >> specForProcessWrapper: spec [
	spec 
		configuration: 'ProcessWrapper' 
		with: [ 
			spec
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo60/main' ]
]

{ #category : #baselines }
BaselineOfGraphViz >> specForXMLParserPharo7: spec [		
		
	spec
		project: 'XMLParser'
		with: [ 
			spec
				className: #ConfigurationOfXMLParser;
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ]
]

{ #category : #baselines }
BaselineOfGraphViz >> specForXMLParserPharo8: spec [		
		
	spec
		baseline: 'XMLParser' 
		with: [ 
			spec 
				repository: 'github://pharo-contributions/XML-XMLParser/src';
				loads: 'Core' ].
]
