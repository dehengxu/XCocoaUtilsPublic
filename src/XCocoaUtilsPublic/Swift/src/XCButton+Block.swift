//
//  NX_UIButton.swift
//  NXPlayground
//
//  Created by NicholasXu on 2020/8/14.
//  Copyright © 2020 NicholasXu. All rights reserved.
//
#if os(iOS)
import UIKit

@objc public extension UIButton {
    
    fileprivate class BlockButton: UIButton {
        var handleBlock: ((_ sender: UIControl)->Void)?
        
        @objc func _private_onClick(_ sender: UIControl) {
            if let blk = self.handleBlock {
                blk(self)
            }
        }
        
        override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
			if (self == target as! NSObject) && self.isKind(of: UIButton.BlockButton.self) && NSStringFromSelector(action) == "_private_onClick:" {
				super.addTarget(target, action: action, for: controlEvents)
			}else {
				print("BlockButton should not use selector:  \(NSStringFromSelector(#selector(UIButton.addTarget(_:action:for:))))")
			}
        }
    }
    
    class func blockButton(type: UIButton.ButtonType , _ handler:((_ sender: Any)->Void)? = nil) -> UIButton {
        let btn = BlockButton(type: type)
        btn.addTarget(btn, action: #selector(BlockButton._private_onClick(_:)), for: .touchUpInside)
        btn.handleBlock = handler
        return btn
    }
    
    @objc func setHandler(_ handler:((_ sender: UIControl)->Void)?) {
        if let blkBtn = self as? BlockButton {
            blkBtn.handleBlock = handler
        }
    }
    
}
#else

#endif
