external
runOSProcess: command with: arguments
	" Private - GraphViz should be present in the PATH environment variable "
	
	WinShell 
		shellExecute: WinWindow foregroundWindow
		operation: 'open'
		file: command
		parameters: arguments
		directory: self outputPath
		show: 0