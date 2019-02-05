"
A PDGraphVizGenerator is a class able to generate a dot file from a package cycle (PDPackageCycle)
"
Class {
	#name : #PDPackageCycleGenerator,
	#superclass : #PDGraphVizGenerator,
	#instVars : [
		'packageCycle'
	],
	#category : #'Package-Dependencies-Core'
}

{ #category : #'instance creation' }
PDPackageCycleGenerator class >> newWith: aPackageCycle named: aString [
	
	| generator |
	generator := self new.
	generator packageCycle: aPackageCycle.
	generator nameOfGraph: aString.
	generator buildGraphViz.
	^ generator
	
]

{ #category : #'build items' }
PDPackageCycleGenerator >> buildEdges [
	packageCycle packages
		do: [ :package | 
			(packageCycle dependentPackagesFrom: package)
				do: [ :dependentPackage | graphviz add: package packageName -> dependentPackage packageName with: { #label -> (package dependenciesSizeTo: dependentPackage) } ] ]
		displayingProgress: 'Building edges'
]

{ #category : #'build items' }
PDPackageCycleGenerator >> buildNodes [
	
	packageCycle packages 	
		do: [ :package |
			graphviz add: package packageName.
			 ] displayingProgress: 'Building nodes'
]

{ #category : #accessing }
PDPackageCycleGenerator >> packageCycle [
	^ packageCycle
]

{ #category : #accessing }
PDPackageCycleGenerator >> packageCycle: anObject [
	packageCycle := anObject
]
