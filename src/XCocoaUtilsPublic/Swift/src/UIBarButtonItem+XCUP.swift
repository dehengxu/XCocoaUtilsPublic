//
//  UIBarButtonItem+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/10/17.
//

import UIKit

public extension UIBarButtonItem {

	@objc convenience init(XCUPTitle buttonTitle: String, target: AnyObject, selector: Selector, buttonSize size: CGSize = CGSize(width: 64, height: 44), buttonType type: UIButton.ButtonType = .system, forEvent: UIControl.Event = .touchUpInside) {
		let btn = UIButton(type: type)
		btn.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		btn.setTitle(buttonTitle, for: .normal)
		btn.addTarget(target, action: selector, for: forEvent)
		self.init(customView: btn)
	}

	@objc func xcup_customButton() -> UIButton? {
		return self.customView as? UIButton
	}
}

