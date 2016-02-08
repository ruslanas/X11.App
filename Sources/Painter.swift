import R.Xlib

class Painter {

    var windowManager = WindowManager()

    func draw() { }

    func line(x1: Int, y1: Int, x2: Int, y2: Int) {
        XDrawLine(
            windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
            Int32(x1), Int32(y1), Int32(x2), Int32(y2)
        )
    }
    func circle(x: Int, _ y: Int, _ r: Int) {
        XDrawArc(
            windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
            Int32(x-r), Int32(y-r), UInt32(r*2), UInt32(r * 2), 0, 360 * 64)
    }

    func drawBorder(x: Int, _ y: Int, _ width: Int, _ height: Int) {
		XDrawRectangle(
			windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
			Int32(x), Int32(y), UInt32(width), UInt32(height))
	}

	func drawString(x: Int, _ y: Int, _ value: String) {
		XDrawString(
			windowManager.d, windowManager.w, windowManager.s.memory.default_gc,
			Int32(x), Int32(y), value, Int32(value.characters.count))
	}
}
