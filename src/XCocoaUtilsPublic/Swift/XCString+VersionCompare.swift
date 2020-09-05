//
//  XCString+VersionCompare.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/9/5.
//

import Foundation

@objc public enum NXComparisonResult: Int {
	case equalTo = 0
	case lessThan = -1
	case greaterThan = 1
}

public func compareVersions(ver1: String, ver2: String) -> NXComparisonResult {
	var comp1 = ver1.components(separatedBy: ".")
	var comp2 = ver2.components(separatedBy: ".")

	func resizeTo(_ comp: inout [String], newSize: Int) {
		let delta = newSize - comp.count
		//print("delta: \(delta)")
		if delta <= 0 {
			return
		}
		for _ in (1...delta) {
			comp.append("0")
			//print("comp: \(comp)")
		}
	}

	let newSize = max(comp1.count, comp2.count)
	if comp1.count > comp2.count {
		resizeTo(&comp2, newSize: newSize)
	}else if comp1.count < comp2.count {
		resizeTo(&comp1, newSize: newSize)
	}

	//print("aligned version: ")
	//print("\(comp1)")
	//print("\(comp2)")

	for i in (0..<comp1.count) {
		if comp1[i].compare(comp2[i]) == .orderedDescending {
			return .greaterThan
		}
		if comp1[i].compare(comp2[i]) == .orderedAscending {
			return .lessThan
		}
	}
	return .equalTo
}

public extension String {
	func compareVersion(_ version: String) -> NXComparisonResult {
		return compareVersions(ver1: self, ver2: version)
	}
}

public extension NSString {
	func compareVersion(_ version: NSString) -> NXComparisonResult {
		return compareVersions(ver1: self as String, ver2: version as String)
	}
}
