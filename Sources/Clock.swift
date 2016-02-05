// Clock
// @author Ruslanas Balčiūnas <ruslanas.com@gmail.com>

import Foundation

class Clock:Label {
	override var value:String {
		get {
			return NSDate().description
		}
		set { }
	}
}
