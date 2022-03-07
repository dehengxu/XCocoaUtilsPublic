//
//  XCGeometry.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/10/10.
//

import CoreGraphics

extension CGRect {

    static var iPhone11Size: CGSize {
        get { CGSize(width: 428, height: 926) }
    }

    static var iPhoneXSize: CGSize {
        get { CGSize(width: 355, height: 655) }
    }

	func xcupCenter() -> CGPoint {
		return CGPoint(x: self.origin.x + self.size.width / 2.0, y: self.origin.y + self.size.height / 2.0)
	}
    
}
