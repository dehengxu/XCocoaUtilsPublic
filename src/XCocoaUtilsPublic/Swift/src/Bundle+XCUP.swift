//
//  Bundle+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2021/12/15.
//

import Foundation

public extension Bundle {

	func xcupInfoStringValue(forKey: String) -> String? {
		return self.infoDictionary?[forKey] as? String
	}

	func xcupBundleIdentifier() -> String {
		return self.xcupInfoStringValue(forKey: "CFBundleIdentifier") ?? ""
	}

	func xcupAppName() -> String {
		return self.xcupInfoStringValue(forKey: "CFBundleName") ?? ""
	}

	func xcupAppVersion() -> String {
		return self.xcupInfoStringValue(forKey: "CFBundleShortVersionString") ?? ""
	}

	func xcupBundleVersion() -> String {
		return self.xcupInfoStringValue(forKey: "CFBundleVersion") ?? ""
	}

	func xcupQueriesSchemes() -> [String] {
		if let info = self.infoDictionary, let schemes = info["LSApplicationQueriesSchemes"] as? [String] {
			return schemes
		}
		return []
	}
}
