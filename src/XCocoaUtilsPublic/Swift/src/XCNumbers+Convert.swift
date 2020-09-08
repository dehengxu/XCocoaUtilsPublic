//
//  Numbers.swift
//  xblibs
//
//  Created by Deheng Xu on 2020/9/8.
//

import Foundation
import CoreGraphics

public extension Float {
	var xc_CGFloat: CGFloat {
		get {
			return CoreGraphics.CGFloat(self)
		}
	}
}

public extension Double {
	var xc_CGFloat: CGFloat {
		get {
			return CoreGraphics.CGFloat(self)
		}
	}
}

public extension CGFloat {

	var xc_float: Float {
		get {
			return Swift.Float(self)
		}
	}

	var xc_double: Double {
		get {
			return Swift.Double(self)
		}
	}

}
