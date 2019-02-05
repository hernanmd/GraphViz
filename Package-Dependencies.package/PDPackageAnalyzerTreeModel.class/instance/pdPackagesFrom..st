accessing
pdPackagesFrom: selectedItems
	^ selectedItems collect: [ :item | PDPackage on: (RPackageSet named: item content packageName asString) ]