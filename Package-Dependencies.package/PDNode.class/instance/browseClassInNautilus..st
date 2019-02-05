browse-nautilus
browseClassInNautilus: aClass
	| nautilus |
	
	nautilus := self rootNode packageTreeNautilus.
	self setSelectionOnMethod: nil class: aClass with: nautilus.
	self refreshNautilus: nautilus.