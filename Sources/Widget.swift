// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

protocol Drawable {
	func draw()
}

class Widget {

	var windowManager = WindowManager()
	var x: Int = 0
	var y: Int = 0
	var width: Int = 200
	var height: Int = 200

	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}
}