//
//  UIViewController+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2021/12/15.
//

#if os(iOS)
import UIKit

public extension UIViewController {

	public func withNavgationAsPossible() -> UINavigationController {
		if let nav = self.navigationController {
			return nav
		} else {
			let nav = UINavigationController(rootViewController: self)
			return nav
		}
	}
	
}

#endif
