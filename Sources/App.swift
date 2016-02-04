// Application base
// Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import Dispatch

class App {

	func run(task: (Void) -> Void) {

	    let q2 = dispatch_queue_create("lt.wri.queue.main", nil)
	    dispatch_async(q2, task)

	}
}
