Class {
	#name : #OSWinSubprocessGraphVizGenerator,
	#superclass : #OSSubprocessGVGenerator,
	#category : #'GraphViz-Generators-OSWinSubprocess'
}

{ #category : #generating }
OSWinSubprocessGraphVizGenerator >> subprocessClass [

	^ OSWSWinProcess
]
