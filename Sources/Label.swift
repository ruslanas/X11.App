// Label
// Simple drawable
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib

class Label:Widget {
	var value = "___"
}

extension Label:Drawable {
	func draw() {
		XDrawString(
			windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
			Int32(x), Int32(y), value, Int32(value.characters.count)) 
	}
}
