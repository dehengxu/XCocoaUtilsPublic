//
//  NX_UIButton.swift
//  NXPlayground
//
//  Created by NicholasXu on 2020/8/14.
//  Copyright © 2020 NicholasXu. All rights reserved.
//

#if os(iOS)
import UIKit


fileprivate class UIButtonPrivate: UIButton {
	static var key = "_800e8c_btn_handler" // 8008ec: sha256(nx)[0,5]
}

private protocol UIButtonWithClosure {}
extension UIButton: UIButtonWithClosure {

	/// UIButton with closure, prefers target-selector if both exists
	///
	/// - Parameters:
	///   - xcupTitle: title
	///   - titleColor: title color
	///   - target: target
	///   - selector: selector
	///   - closure: closure
	///   - type: UIButtonType
	/// - Returns: UIButton
	public static func xcup_button(title: String? = nil, titleColor: UIColor = .black, target: AnyObject? = nil, selector: Selector? = nil, closure:((_ sender: UIButton) -> Void)? = nil, type: UIButton.ButtonType = .custom, forEvent: UIControl.Event = .touchUpInside) -> Self {
		let btn = Self(type: type)
		btn.setTitle(title, for: .normal)
		btn.setTitleColor(titleColor, for: .normal)
		if let sel = selector, let tar = target {
			btn.addTarget(tar, action: sel, for: .touchUpInside)
		} else if let handler = closure {
			btn.addTarget(btn, action: #selector(__800e8c_forwardHandle), for: forEvent)
			btn.handler = handler
		}
		return btn
	}

	public var handler: ((_ sender: UIButton) -> Void)? {

		set {
			objc_setAssociatedObject(self, &UIButtonPrivate.key, newValue, .OBJC_ASSOCIATION_COPY)
			if let actions = self.actions(forTarget: self, forControlEvent: .touchUpInside) {
				for action in actions {
					self.removeTarget(self, action: Selector(action), for: .touchUpInside)
				}
			}
			self.addTarget(self, action: #selector(__800e8c_forwardHandle), for: .touchUpInside)
		}
		get {
			return objc_getAssociatedObject(self, &UIButtonPrivate.key) as? ((_ sender: UIButton)->Void)
		}
	}

	@objc private func __800e8c_forwardHandle() {
		self.handler?(self)
	}
}

public extension UIButton {

	func xcup_withImage(_ imageName: String, for: UIControl.State = .normal) -> Self {
		return xcup_withImage(UIImage(named: imageName), for: `for`)
	}

	func xcup_withImage(_ image: UIImage?, for: UIControl.State = .normal) -> Self {
		self.setImage(image, for: `for`)
		return self
	}

	func xcup_withTitle(_ title: String?, for: UIControl.State = .normal) -> Self {
		self.setTitle(title, for: `for`)
		return self
	}

	func xcup_withTitleColor(_ color: UIColor = .black, for: UIControl.State = .normal) -> Self {
		self.setTitleColor(color, for: `for`)
		return self
	}

	func xcup_withBarButtonItemSize(width: CGFloat = 64.0, height: CGFloat = 44.0) -> Self {
		var frame = self.frame
		frame.size.width = width
		frame.size.height = height
		self.frame = frame
		return self
	}

	override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
		super.addTarget(target, action: action, for: controlEvents)
	}

}

@objc public extension UIButton {
    fileprivate class BlockButton: UIButton {
        var handleBlock: ((_ sender: UIControl)->Void)?
        
        @objc func __800e8c_forwardHandle(_ sender: UIControl) {
            if let blk = self.handleBlock {
                blk(self)
            }
        }
        
		override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
			if (self == target as! NSObject) && self.isKind(of: UIButton.BlockButton.self) && NSStringFromSelector(action) == "__800e8c_forwardHandle:" {
				super.addTarget(target, action: action, for: controlEvents)
			}else {
				print("BlockButton should not use selector:  \(NSStringFromSelector(#selector(UIButton.addTarget(_:action:for:))))")
			}
        }
    }
    
    class func xcup_blockButton(type: UIButton.ButtonType , handler:((_ sender: Any)->Void)? = nil) -> UIButton {
        let btn = BlockButton(type: type)
        btn.addTarget(btn, action: #selector(BlockButton.__800e8c_forwardHandle(_:)), for: .touchUpInside)
        btn.handleBlock = handler
        return btn
    }

	func xcup_setHandler(_ handler: ((_ sender: UIControl)->Void)?) {
		if let btn = self as? BlockButton {
			btn.handleBlock = handler
		}
	}
    
}
#else

#endif
