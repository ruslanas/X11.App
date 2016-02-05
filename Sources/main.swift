// Swift X11 libdispatch experiment on Linux
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib
import Dispatch
import Foundation

XInitThreads();

let wm = WindowManager()
wm.launch()

var clock = Clock(20, 50)
var label = Label(20, 40)
label.value = "UTC"

clock.addEventListener("click") { (x, y) -> Void in
    print("\(x);\(y)")
}

wm.link(clock)
wm.link(label)

dispatch_main()
