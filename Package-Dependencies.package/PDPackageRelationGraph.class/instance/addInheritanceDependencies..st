adding
addInheritanceDependencies: aPackage
	| package |
	self package: aPackage
		classesDo: [ :class | 
			class superclass ifNotNil: [ 
					package := self packageForBehavior: class superclass.
					aPackage
						add:
							((PDInheritanceDependency from: aPackage to: package)
								theClass: class;
								superclass: class superclass).
					self addPackage: package ] ]