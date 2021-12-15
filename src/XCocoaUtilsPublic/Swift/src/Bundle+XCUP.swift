//
//  Bundle+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2021/12/15.
//

import Foundation

extension Bundle {

	func xcupInfoStringValue(forKey: String) -> String? {
		return self.infoDictionary?[forKey] as? String
	}

	func xcupBundleIdentifier() -> String {
		return self.xcupInfoStringValue(forKey: "CFBundleIdentifier") ?? ""
	}

	func xcupAppName() -> String {
		return self.xcupInfoStringValue(forKey: "CFBundleName") ?? ""
	}

	func xcupQueriesSchemes() -> [String] {
		if let info = self.infoDictionary, let schemes = info["LSApplicationQueriesSchemes"] as? [String] {
			return schemes
		}
		return []
	}
}
