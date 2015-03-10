external
runOSProcess: command with: arguments
	" Private - GraphViz should be present in the PATH environment variable "
	
	NBWin32Shell
		shellExecute: NBWin32Window getForegroundWindow
		operation: 'open'
		file: command
		parameters: arguments
		directory: self outputPath
		show: 0