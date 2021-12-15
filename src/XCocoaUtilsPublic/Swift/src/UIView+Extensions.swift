//
//  UIView+Extensions.swift
//  Test
//
//  Created by NicholasXu on 2021/11/22.
//  Copyright © 2021 com.dehengxu.ios. All rights reserved.
//

import UIKit

extension UIView {
	typealias T = UIView

	public var cornerRadius: CGFloat {
		set {
			self.layer.cornerRadius = newValue
			self.layer.masksToBounds = true
		}
		get {
			return self.layer.cornerRadius
		}
	}

    @objc func handleClick_close(_ sender: UIButton) {
        self.removeFromSuperview()
    }

	public var width: CGFloat {
		get {
			return self.frame.size.width
		}
		set {
			self.frame.size.width = newValue
		}
	}

	public var height: CGFloat {
		get {
			return self.frame.size.height
		}
		set {
			self.frame.size.height = newValue
		}
	}

	public var x: CGFloat {
		get {
			return self.frame.origin.x
		}
		set {
			self.frame.origin.x = newValue
		}
	}

	public var y: CGFloat {
		get {
			return self.frame.origin.y
		}
		set {
			self.frame.origin.y = newValue
		}
	}

	public func resize(_ handler:(_ width: inout CGFloat, _ height: inout CGFloat) -> Void ) {
		var frame = self.frame
		var width: CGFloat = frame.size.width
		var height: CGFloat = frame.size.height
		handler(&width, &height)
		frame.size.width = width
		frame.size.height = height
		self.frame = frame
	}

	public func moveToCenter(_ handler:(_ centerX: inout CGFloat, _ centerY: inout CGFloat) -> Void) {
		var x = self.center.x
		var y = self.center.y
		handler(&x, &y)
		self.center.x = x
		self.center.y = y
	}

	public func moveToOrigin(_ handler:(_ x: inout CGFloat, _ y: inout CGFloat) -> Void) {
		var x = self.frame.origin.x
		var y = self.frame.origin.y
		handler(&x, &y)
		self.frame.origin.x = x
		self.frame.origin.y = y
	}

}

