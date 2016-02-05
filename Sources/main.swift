// Swift X11 libdispatch experiment on Linux
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib
import Dispatch
import Foundation

XInitThreads();

let wm = WindowManager()
let app = App()

wm.launch()

app.run {
    var widget = Widget(20, 50)

    wm.widgets.append(widget)

    while !wm.stop {
        sleep(1)
        let time = NSDate()
        widget.value = time.description
        wm.redraw()
    }

    print("Application stopped")
    exit(0)
}

dispatch_main()
