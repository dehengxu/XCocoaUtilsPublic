//
//  String_Disgest.swift
//  NXPlayground
//
//  Created by Deheng Xu on 2020/8/30.
//  Copyright © 2020 NicholasXu. All rights reserved.
//

import Foundation
import CommonCrypto

public protocol LBrowserDigesting {
	func MD5(lowercase: Bool) -> String
	func SHA256(lowercase: Bool) -> String
	func SHA512(lowercase: Bool) -> String
}

protocol LBrowserNSURLSigning {
	func sign(with algo: (String)->String, isAscending :Bool) -> NSURL?
	func sortedQuery(isAscending :Bool) -> String
}

public extension Array {

	/// Joint array and convert lowercase
	/// - Returns: String
	func lowerString() -> String {

		let a = self.map { (e: Element) -> String in
			return String(format: "%0x", e as! CVarArg)
		}.joined()

		return a
	}

	/// Joint array and convert uppercase
	/// - Returns: String
	func upperString() -> String {

		let a = self.map { (e: Element) -> String in
			return String(format: "%0X", e as! CVarArg)
		}.joined()

		return a
	}

}

extension String: LBrowserDigesting {

	public func MD5(lowercase: Bool = true) -> String {
		var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

		var ctx = CC_MD5_CTX()
		CC_MD5_Init(&ctx)
		CC_MD5_Update(&ctx, self, CC_LONG(self.count))

		_ = withUnsafeMutablePointer(to: &digest[0]) {
			CC_MD5_Final($0, &ctx)
		}

		let msg =
			lowercase ? digest.lowerString() : digest.upperString()
		return msg
	}

	public func SHA256(lowercase: Bool = true) -> String {
		var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
		var ctx = CC_SHA256_CTX()
		_ = CC_SHA256_Init(&ctx)
		CC_SHA256_Update(&ctx, self, CC_LONG(self.count))
		_ = withUnsafeMutablePointer(to: &digest[0], {
			CC_SHA256_Final($0, &ctx)
		})

		let msg = lowercase ? digest.lowerString() : digest.upperString()
		return msg
	}

	public func SHA512(lowercase: Bool = true) -> String {
		var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
		var ctx = CC_SHA512_CTX()
		_ = CC_SHA512_Init(&ctx)
		CC_SHA512_Update(&ctx, self, CC_LONG(self.count))
		_ = withUnsafeMutablePointer(to: &digest[0], {
			CC_SHA512_Final($0, &ctx)
		})

		let msg = lowercase ? digest.lowerString() : digest.upperString()
		return msg
	}

}

class SignedURL: NSURL {
	var signName = "sign"
}

extension NSURL: LBrowserNSURLSigning {

	public func useSignKeyName(_ keyName: String) -> NSURL? {
		if let abstr = self.absoluteString {
			let url = SignedURL(string: abstr)
			url?.signName = keyName
			return url
		}
		return nil
	}

	public func URL() -> URL? {
		if let abstr = self.absoluteString {
			return Foundation.URL(string: abstr)
		}else {
			return nil
		}
	}

	public func sign(with algo: (String) -> String, isAscending: Bool = true) -> NSURL? {
		let shortUrl = String(format: "%@://%@%@", (self.scheme != nil) ? self.scheme! : "", (self.host != nil) ? self.host! : "", (self.path != nil) ? self.path! : "")

		let queryString = self.sortedQuery(isAscending: isAscending)

		let absoluteString = String(format: "%@\(queryString.count > 0 ? "?" : "")%@", shortUrl, queryString )

		//print("absoluteString:", absoluteString)
		let signature = algo(absoluteString)
		//print("signature:", signature)
		if let url = self as? SignedURL {
			return NSURL(string: "\(absoluteString)&\(url.signName)=\(signature)")
		}else {
			return NSURL(string: "\(absoluteString)&sign=\(signature)")

		}
	}

	public func sortedQuery(isAscending: Bool = true) -> String {
		var queryString: String = ""

		let urlComps = URLComponents(string: self.absoluteString ?? "")
		if var queryItems = urlComps?.queryItems {
			queryItems.sort { (i1: URLQueryItem, i2: URLQueryItem) -> Bool in
				if isAscending {
					return i1.name < i2.name
				}else {
					return i1.name > i2.name
				}
			}
			var iter = queryItems.makeIterator()
			// append first
			if let item = iter.next() {
				queryString += "\(item.name)="
				queryString += item.value ?? ""
			}
			// append left begins with sign "&"
			for item in iter {
				queryString += "&\(item.name)="
				queryString += item.value ?? ""
			}
		}
		return queryString
	}
}

extension URL {
	public func NSURL() -> Foundation.NSURL? {
		return Foundation.NSURL(string: self.absoluteString)
	}
}
