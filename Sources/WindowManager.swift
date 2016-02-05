// WindowManager redraws widgets
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib
import R.X
import Dispatch
import Foundation

class WindowManager {

	var widgets: [Widget] = []

	let title = "Window"
	
	var width:UInt32 = 200
	var height:UInt32 = 100

	var stop = false
	
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
			d, rootWindow, 10, 10, width, height, 2,
			s.memory.black_pixel, s.memory.white_pixel)

	}

	func redraw() {
		if stop {
			return
		}

		// Expose
		let e:UnsafeMutablePointer<_XEvent> = UnsafeMutablePointer<_XEvent>.alloc(1)
		e.memory.type = Expose
		e.memory.xexpose.window = w
		XSendEvent(d, w, False, ExposureMask, e)
		XFlush(d)
	}

	func launch() {

	    let q = dispatch_queue_create("lt.wri.queue.ui", nil)

		XSelectInput(d, w, ExposureMask | KeyPressMask)
		XMapWindow(d, w)

	    dispatch_async(q) {
	        self.loop()
	    }

	    print("Window launched")

	}

	func close() {

		XFreeGC(d, s.memory.default_gc)
		XDestroyWindow(d, w)
		// XCloseDisplay(d) // segfault
		stop = true
	}

	func loop() {

		loop: while !stop {

			XNextEvent(d, e)
			XClearWindow(d, w)

			switch e.memory.type {
			case Expose:

				for wgt in widgets {	
					XDrawString(
						d, w, s.memory.default_gc,
						Int32(wgt.x), Int32(wgt.y), wgt.value, Int32(wgt.value.characters.count)) 
				}

				break

			case KeyPress:
				close()
				break loop
			
			default: fatalError("Unknown Event")
			
			}

		}

	}
}
