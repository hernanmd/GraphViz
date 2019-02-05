browse-nautilus
browseInNautilus
	| methodToBrowse |
	methodToBrowse := self content method.
	"Nautilus have a problem to refresh, repeat 2 times the operation"
	2 timesRepeat: [ self browseMethodInNautilus: methodToBrowse ].