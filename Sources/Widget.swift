// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib

protocol Drawable {
	func draw()
}

class Widget {

	var windowManager = WindowManager()
	var x: Int = 0
	var y: Int = 0
	var width: Int = 100
	var height: Int = 10
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

	func drawBorder() {
		XDrawRectangle(
			windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
			Int32(x), Int32(y), UInt32(width), UInt32(height))
	}

	func drawString(x: Int, _ y: Int, _ value: String) {
		XDrawString(
			windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
			Int32(x), Int32(y + height), value, Int32(value.characters.count)) 
	}
}