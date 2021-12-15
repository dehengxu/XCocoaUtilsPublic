//
//  LBWSResponderMessage.swift
//  NXPlayground
//
//  Created by NicholasXu on 2020/8/31.
//  Copyright © 2020 NicholasXu. All rights reserved.
//
#if os(iOS)
import UIKit

extension UIResponder {
    
    @objc public func sendMessage(_ action: Selector, sender: Any) {
        var responder: UIResponder? = self
        repeat {
            if let resp = responder {
				if resp.responds(to: action) && resp.canBecomeFirstResponder {
                    resp.perform(action, with: sender)
                    break
                }
            }
            responder = responder?.next
        }while(responder != nil)
    }
    
}
#else

import Foundation

#endif
