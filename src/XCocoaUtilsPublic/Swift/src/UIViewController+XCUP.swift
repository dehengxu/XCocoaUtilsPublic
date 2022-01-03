//
//  UIViewController+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2021/12/15.
//

#if os(iOS)
import UIKit

@objc public extension UIViewController {

	static func xibFileNameDefaultSuffix() -> String {
		return UIDevice.current.model.lowercased().hasSuffix("ipad") ? "iPad" : "iPhone"
	}

	static func viewController(nibName: String, bundle bundleOrNil: Bundle) -> UIViewController {
		if let path = Bundle.main.path(forResource: "\(nibName)_\(xibFileNameDefaultSuffix())", ofType: "nib"), !FileManager.default.fileExists(atPath: path) {
			return self.init(nibName: nibName, bundle: bundleOrNil)
		} else {
			return self.init(nibName: "\(nibName)_\(xibFileNameDefaultSuffix())", bundle: bundleOrNil)
		}
	}

	func withNavgationAsPossible() -> UINavigationController {
		if let nav = self.navigationController {
			return nav
		} else {
			let nav = UINavigationController(rootViewController: self)
			return nav
		}
	}

	func isSupportInteractivePopGestureRecognizer() -> Bool {
		if let _ = self as? UINavigationController, #available(iOS 7.0, *) {
			return true
		}
		return false
	}


	func xcup_navigationController() -> UINavigationController {
		if let nav = self.navigationController {
			return nav
		} else {
			let nav = UINavigationController(rootViewController: self)
			return nav
		}
	}

	func xcup_present(_ viewController: UIViewController, animated: Bool = true, presentationStyle: UIModalPresentationStyle = .fullScreen, transitionStyle:UIModalTransitionStyle = .coverVertical, orNeedNavigation: Bool = false, completion: (() -> Void)? = nil) {
		var targetVc: UIViewController = viewController
		if let nav = self.navigationController {
			targetVc = nav
		} else if orNeedNavigation {
			targetVc = UINavigationController(rootViewController: viewController)
		}
		targetVc.modalTransitionStyle = transitionStyle
		targetVc.modalPresentationStyle = presentationStyle
		self.present(targetVc, animated: animated, completion: completion)
	}

	func xcup_dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
		if let nav = self.navigationController {
			nav.dismiss(animated: animated, completion: completion)
		} else {
			self.dismiss(animated: animated, completion: completion)
		}
	}

	func setNavigationBarColor(_ color: UIColor, for barMetrics: UIBarMetrics = .default) {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: color, size: self.navigationController?.navigationBar.frame.size ?? .zero), for: barMetrics)
	}
}

#endif
