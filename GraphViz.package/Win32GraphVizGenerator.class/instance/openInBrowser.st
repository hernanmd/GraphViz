creation
openInBrowser

	| file |
	file := self  make: #svg.
	file := self writeHtmlSvgFor: file.
	WinShell shellOpen: file