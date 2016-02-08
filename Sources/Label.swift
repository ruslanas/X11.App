// Label
// Simple drawable
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

class Label:Widget {
	var value = "___"
	var border = true
	override func draw() {
		drawString(x, y, value)
		if border {
			drawBorder(x, y, width, height)
		}
	}
}
