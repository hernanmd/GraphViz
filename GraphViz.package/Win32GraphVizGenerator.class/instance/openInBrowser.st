creation
openInBrowser

	| file |
	file := self  make: #svg.
	file := self writeHtmlSvgFor: file.

	NBWin32Shell shellOpen: file