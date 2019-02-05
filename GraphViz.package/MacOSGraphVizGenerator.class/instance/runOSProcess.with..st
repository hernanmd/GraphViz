private
runOSProcess: command with: arguments 

	| helperCommand |
	"helperCommand := '/Applications/GraphViz.app/Contents/MacOS/', command."
	helperCommand := '/usr/local/bin/', command.
	helperCommand := helperCommand, ' ', arguments.

	self runWithSystemFramework: helperCommand.
	