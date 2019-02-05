adding
addExtensionDependencies: aPDPackage
	| sourcePackage |
	
	aPDPackage rPackageSet extensionMethods
		do: [ :method | 
			sourcePackage := self packageForBehavior: method actualClass.
			self addPackage: sourcePackage.
			sourcePackage
				add:
					((PDExtensionDependency from: sourcePackage to: aPDPackage)
						theClass: method actualClass;
						selector: method selector asSymbol;
						method: method).
			 ]