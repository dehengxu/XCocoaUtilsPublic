//
//  XCGeometry.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/10/10.
//

import CoreGraphics

extension CGRect {
	func xcupCenter() -> CGPoint {
		return CGPoint(x: self.origin.x + self.size.width / 2.0, y: self.origin.y + self.size.height / 2.0)
	}
}
