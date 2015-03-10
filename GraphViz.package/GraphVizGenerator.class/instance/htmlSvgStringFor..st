accessing
htmlSvgStringFor: svgFile

	^ String streamContents: [ : stream |
		stream
			nextPutAll: '<html><head><title>';
			nextPutAll: self graph name;
			nextPutAll: '</title></head><body><object type="image/svg+xml" data="';
			nextPutAll: svgFile asFileReference basename;
			nextPutAll: '" width="100%" height="100%" /></body></html>']
	