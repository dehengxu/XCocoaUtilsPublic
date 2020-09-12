//
//  Numbers.swift
//  xblibs
//
//  Created by Deheng Xu on 2020/9/8.
//

import Foundation
import CoreGraphics

public extension Float {
	var CGFloat: CGFloat {
		get {
			return CoreGraphics.CGFloat(self)
		}
	}
}

public extension Double {
	var CGFloat: CGFloat {
		get {
			return CoreGraphics.CGFloat(self)
		}
	}
}

public extension CGFloat {

	var Float: Float {
		get {
			return Swift.Float(self)
		}
	}

	var Double: Double {
		get {
			return Swift.Double(self)
		}
	}

}
