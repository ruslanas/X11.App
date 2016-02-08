// Swift X11 libdispatch experiment on Linux
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import R.Xlib

XInitThreads();

let app = ClockApp()

app.setup()

app.windowManager.launch()
