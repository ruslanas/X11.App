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
    var clock = Label(20, 50)
    var label = Label(20, 40)
    label.value = "The Clock"

    wm.link(clock)
    wm.link(label)

    while !wm.stop {
        sleep(1)
        let time = NSDate()
        clock.value = time.description
        wm.redraw()
    }

    print("Application stopped")
    exit(0)
}

dispatch_main()
