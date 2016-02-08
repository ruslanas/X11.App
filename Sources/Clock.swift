// Clock
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import Foundation

func deg2rad(deg: Int) -> Double {
	return Double(deg - 90) * Double(M_PI) / 180.0
}

class Clock:Widget {

	override func draw() {
		let r = 35.0
		let date = NSDate()
		circle(x, y, Int(r))
		let cal = NSCalendar.currentCalendar()
		let comp = cal.components([.Hour, .Minute, .Second], fromDate: date)!

		let xh = x + Int(cos(deg2rad(comp.hour * 30)) * r / 2)
		let yh = y + Int(sin(deg2rad(comp.hour * 30)) * r / 2)
		line(x, y1: y, x2: xh, y2: yh)

		let xm = x + Int(cos(deg2rad(comp.minute * 6)) * r * 0.8)
		let ym = y + Int(sin(deg2rad(comp.minute * 6)) * r * 0.8)
		line(x, y1: y, x2: xm, y2: ym)

		let xs = x + Int(cos(deg2rad(comp.second * 6)) * r)
		let ys = y + Int(sin(deg2rad(comp.second * 6)) * r)
		line(x, y1: y, x2: xs, y2: ys)

		drawString(2, windowManager.height - 2, date.description)
		drawBorder(x - Int(width / 2), y - Int(height / 2), width, height)
	}
}
