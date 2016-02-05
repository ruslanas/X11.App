// Label
// Simple drawable
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

class Label:Widget {
	var value = "___"
}

extension Label:Drawable {
	func draw() {
		drawString(x, y, value)
		drawBorder()
	}
}
