// Swift X11 libdispatch experiment on Linux
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import Dispatch
import Foundation

let wm = WindowManager()
let app = App()

wm.launch()
app.run {
    let w = Widget()
    wm.widgets.append(w)

    while true {
        sleep(1)
        w.x = random() % 200
        w.y = random() % 200
        wm.redraw()
    }
}

dispatch_main()
