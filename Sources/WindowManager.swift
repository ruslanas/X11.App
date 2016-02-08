// WindowManager redraws widgets
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib
import R.X
import Foundation

class WindowManager {

	var widgets: [Widget] = []

	let title = "Window"

	var width:Int = 200
	var height:Int = 100

	var rootWindow:UInt
	var w:Window
	var d:_XPrivDisplay
	var e:UnsafeMutablePointer<_XEvent> = UnsafeMutablePointer<_XEvent>.alloc(1)
	var s:UnsafeMutablePointer<Screen>

	init() {

		d = XOpenDisplay(nil)
		if d == nil {
			fatalError("cannot open display")
		}

		s = XDefaultScreenOfDisplay(d)
		rootWindow = s.memory.root
		w = XCreateSimpleWindow(
			d, rootWindow, 10, 10, UInt32(width), UInt32(height), 2,
			s.memory.black_pixel, s.memory.white_pixel)

	}

	func redraw() {
		// Expose
		let e:UnsafeMutablePointer<_XEvent> = UnsafeMutablePointer<_XEvent>.alloc(1)
		e.memory.type = Expose
		e.memory.xexpose.window = w
		XSendEvent(d, w, False, ExposureMask, e)
		XFlush(d)
	}

	func launch() {

		XSelectInput(d, w, ExposureMask | KeyPressMask | ButtonPressMask)
		XMapWindow(d, w)

    	self.loop()

	}

	func close() {
		//XFreeGC(d, s.memory.default_gc)
		XDestroyWindow(d, w)
		XCloseDisplay(d)
		exit(1)
	}

	func link(widget: Widget) {
		widget.windowManager = self
		self.widgets.append(widget)
	}

	func loop() {

		loop: while true {

			XNextEvent(d, e)
			let event = e.memory

			switch event.type {
			case Expose:

				XClearWindow(d, w)

				for wgt in widgets {
					wgt.draw()
				}

				break

			case KeyPress:
				close()
				break loop

			case ButtonPress:
				for wgt in widgets {
					let x = Int(event.xbutton.x)
					let y = Int(event.xbutton.y)

					if x > wgt.x && x < wgt.width + wgt.x && wgt.y < y && wgt.height + wgt.y > y {
						wgt.onClick(x, y)
						break
					}
				}
				break

			default: fatalError("Unknown Event")

			}

		}

	}
}
