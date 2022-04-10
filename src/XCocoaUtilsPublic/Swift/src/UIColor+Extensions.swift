//
//  UIColor+Extensions.swift
//  Test
//
//  Created by Deheng Xu on 2021/11/16.
//  Copyright © 2021 com.dehengxu.ios. All rights reserved.
//

import UIKit

public extension UIColor {

	@objc static func randomColor() -> UIColor {
		let range: ClosedRange<UInt> = 0...255
		let r = UInt.random(in: range)
		let g = UInt.random(in: range)
		let b = UInt.random(in: range)
		let a = UInt.random(in: range)
		return UIColor(alpha: a, red: r, green: g, blue: b)
	}

	/// 适配 js.design 颜色复制格式
	/// - Parameters:
	///   - r: Red Int
	///   - g: Green Int
	///   - b: Blue Int
	///   - a: Alpha Int
	/// - Returns: UIColor
	@objc static func rgba(_ r: Int = 0, _ g: Int = 0, _ b: Int = 0, _ a: Int = 255) -> UIColor {
		return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
	}

}
