building
buildWindowNautilus
	| windowNautilus |
	nautilusUI := NautilusUI on: nautilus.
	windowNautilus := NautilusWindow new model: nautilusUI.
	nautilusUI addAll: windowNautilus.
	nautilusUI window: windowNautilus.
	nautilusUI changed: #sourceCodeFrom:.
	nautilusUI setWindowTitle.
	^ windowNautilus