// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib

class Widget:Painter {

	var x: Int = 0
	var y: Int = 0
	var width: Int = 80
	var height: Int = 80
	var listeners: [String: (Int, Int) -> Void] = [:]

	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	func onClick(x: Int, _ y: Int) {
		if listeners["click"] != nil {
			listeners["click"]!(x, y)
		}
	}

	func addEventListener(type: String, handler: ((Int, Int) -> Void)) {
		listeners[type] = handler
	}

}
