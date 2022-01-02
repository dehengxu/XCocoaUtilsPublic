//
//  UIBarButtonItem+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/10/17.
//

#if os(iOS) //os(iOS)
import UIKit

private protocol ButtonAsCustomView {}

extension UIBarButtonItem: ButtonAsCustomView {


	public convenience init(xcupTitle: String? = nil, titleColor: UIColor = .black, target: AnyObject? = nil, selector: Selector? = nil, buttonType: UIButton.ButtonType = .custom, forEvent: UIControl.Event = .touchUpInside) {
		let btn = UIButton.xcup_button(title: xcupTitle, titleColor: titleColor, target: target, selector: selector, closure: nil, type: buttonType)
		self.init(customView: btn)
	}

	public convenience init(xcupTitle: String? = nil, titleColor: UIColor = .black, closure: ((_ sender: UIButton)->Void)? = nil, buttonType: UIButton.ButtonType = .custom, forEvent: UIControl.Event = .touchUpInside) {
		let btn = UIButton.xcup_button(title: xcupTitle, titleColor: titleColor, target: nil, selector: nil, closure: closure, type: buttonType)
		self.init(customView: btn)
	}

	public func xcup_withCustomViewSize(width: CGFloat = 64.0, height: CGFloat = 44.0) -> Self {
		if let view = self.customView {
			view.frame.size.width = width
			view.frame.size.height = height
		}
		return self
	}

	public func xcup_customButton() -> UIButton? {
		return self.customView as? UIButton
	}

}

#endif
