// WindowManager redraws widgets
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib
import R.X
import Dispatch

class WindowManager {

	var widgets: [Widget] = []

	let msg = "Swift Is Fun"

	var x:Int32 = 10
	var y:Int32 = 10

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
			d, rootWindow, 10, 10, 200, 200, 2,
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
	    print("Launching WindowManager")
	    let q = dispatch_queue_create("lt.wri.queue.ui", nil)
	    dispatch_async(q) {
	        self.run()
	    }
	}

	func run() {

		XSelectInput(d, w, ExposureMask | KeyPressMask)

		XMapWindow(d, w)

		loop: while true {

			XNextEvent(d, e)

			switch e.memory.type {
			case Expose:

				for wgt in widgets {	
					XDrawString(
						d, w, s.memory.default_gc,
						Int32(wgt.x), Int32(wgt.y), msg, Int32(msg.characters.count)) 
				}

				break

			case KeyPress:
				
				XDrawRectangle(
					d, w, s.memory.default_gc,
					x, y, 20, 10)

				break // loop
			
			default: fatalError("Unknown Event")
			
			}

		}

	}
}
