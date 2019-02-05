"
A PDPackageAnalyzerDiffTreeModel is to watch what are the difference between two analysis of dependencies.
"
Class {
	#name : #PDPackageAnalyzerDiffTreeModel,
	#superclass : #ComposableModel,
	#instVars : [
		'treeDiff',
		'packageRelationGraphDiff'
	],
	#category : #'Package-Dependencies-UI-Window'
}

{ #category : #specs }
PDPackageAnalyzerDiffTreeModel class >> defaultSpec [
	<spec: #default>
	^ SpecLayout composed newColumn: [ :col | col add: #treeDiff ] yourself
]

{ #category : #'instance creation' }
PDPackageAnalyzerDiffTreeModel class >> newWith: oldRelationGraph on: newRelationGraph [
	^ self new
		initializeWith: oldRelationGraph on: newRelationGraph;
		yourself.
]

{ #category : #initialization }
PDPackageAnalyzerDiffTreeModel >> buildRoots [
	self treeDiff roots: packageRelationGraphDiff packagesDiffToDisplay.
	self treeDiff whenBuiltDo: [ treeDiff rootNodeHolder: [ :item | PDPackageItemDiffNode new content: item ] ]
]

{ #category : #protocol }
PDPackageAnalyzerDiffTreeModel >> extent [
	^ 900@900
]

{ #category : #initialization }
PDPackageAnalyzerDiffTreeModel >> initializeWidgets [
	
	treeDiff := self newTree
		multiSelection: true;
		yourself.
]

{ #category : #initialization }
PDPackageAnalyzerDiffTreeModel >> initializeWith: oldRelationGraph on: newRelationGraph [
	packageRelationGraphDiff := PDPackageRelationGraphDiff new
		oldRelationGraph: oldRelationGraph;
		newRelationGraph: newRelationGraph.
	packageRelationGraphDiff make.
	
	self buildRoots
	
	
]

{ #category : #'instance creation' }
PDPackageAnalyzerDiffTreeModel >> open [	
	^ self openWithSpec
]

{ #category : #protocol }
PDPackageAnalyzerDiffTreeModel >> title [
	^ 'Package Dependencies Analysis Diff'
	
]

{ #category : #accessing }
PDPackageAnalyzerDiffTreeModel >> treeDiff [
	^ treeDiff
]
