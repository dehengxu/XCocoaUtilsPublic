//
//  Numbers.swift
//  xblibs
//
//  Created by Deheng Xu on 2020/9/8.
//

import Foundation
import CoreGraphics

//MARK: - NSIndexPath and IndexPath

extension IndexPath {
	var NSIndexPath: NSIndexPath {
		return self as NSIndexPath
	}
}

extension NSIndexPath {
	var IndexPath: IndexPath {
		return self as IndexPath
	}
}

//MARK: - NSString and String

extension String {
	var NSString: NSString {
		return self as NSString
	}
}

extension NSString {
	var String: String {
		return self as String
	}
}

//MARK: - Numbers

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
