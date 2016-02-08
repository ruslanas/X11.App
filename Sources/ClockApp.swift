import Foundation
import Dispatch

class ClockApp:App {
    func setup() {
        let clock = Clock(100, 50)

        clock.addEventListener("click") { (x, y) -> Void in
            let q = dispatch_queue_create("lt.wri.queue.background", nil)
            dispatch_async(q) {
                sleep(5) // simulate lengthy operation
                print("\(x);\(y)")
            }
        }

        windowManager.link(clock)
        let label = Label(2, 12)
        label.value = "El Clocko"
        label.border = false
        windowManager.link(label)
        let q = dispatch_queue_create("lt.wri.queue.tick", nil)
		dispatch_async(q) {
			let timer = NSTimer.scheduledTimer(0.5, repeats: true) {
				timer in
				self.windowManager.redraw()
			}

			let tick = NSRunLoop.currentRunLoop()
			tick.addTimer(timer, forMode: NSDefaultRunLoopMode)
			tick.run()
		}
    }
}
