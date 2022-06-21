//
//  String_Disgest.swift
//  NXPlayground
//
//  Created by Deheng Xu on 2020/8/30.
//  Copyright © 2020 NicholasXu. All rights reserved.
//

import Foundation
import CommonCrypto
#if canImport(CryptoKit)
import CryptoKit
#endif

public protocol XCUPDigesting {

    func MD5(lowercase: Bool) -> [UInt8]
    func SHA256(lowercase: Bool) -> [UInt8]
    func SHA512(lowercase: Bool) -> [UInt8]

	func MD5(lowercase: Bool) -> String
	func SHA256(lowercase: Bool) -> String
	func SHA512(lowercase: Bool) -> String
}

protocol XCURLSigning {
	func sign(with algo: (String)->String, isAscending :Bool) -> URL?
	func sortedQuery(isAscending :Bool) -> String
}

public extension IndexingIterator {

    /// Joint array and convert lowercase
    /// - Returns: String
    func xcup_ToHexString(_ lowercase: Bool = false) -> String where Element: Numeric {

        let a = self.map { (e: Element) -> String in
            return lowercase ? String(format: "%0x", e as! CVarArg) : String(format: "%0X", e as! CVarArg)
        }.joined()

        return a
    }

}

public extension Array {

	/// Joint array and convert lowercase
	/// - Returns: String
    func xcup_ToHexString(_ lowercase: Bool = false) -> String where Element: Numeric {
		let a = self.map { (e: Element) -> String in
            return lowercase ? String(format: "%0x", e as! CVarArg) : String(format: "%0X", e as! CVarArg)
		}.joined()

		return a
	}


}

extension Data: XCUPDigesting {
    public func MD5(lowercase: Bool) -> [UInt8] {
        if #available(iOS 13.0, *) {
            return CryptoKit.Insecure.MD5.hash(data: self).makeIterator().filter { _ in true }
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            var ctx = CC_MD5_CTX()
            CC_MD5_Init(&ctx)
            CC_MD5_Update(&ctx, self.filter { _ in true }, CC_LONG(self.count))
            _ = withUnsafeMutablePointer(to: &digest[0]) {
                CC_MD5_Final($0, &ctx)
            }
            return digest
        }
    }

    public func SHA256(lowercase: Bool) -> [UInt8] {
        if #available(iOS 13.0, *) {
            return CryptoKit.SHA256.hash(data: self).makeIterator().filter { _ in true }
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            var ctx = CC_SHA256_CTX()
            _ = CC_SHA256_Init(&ctx)
            CC_SHA256_Update(&ctx, self.filter { _ in true } , CC_LONG(self.count))
            _ = withUnsafeMutablePointer(to: &digest[0], {
                CC_SHA256_Final($0, &ctx)
            })
            return digest
        }
    }

    public func SHA512(lowercase: Bool) -> [UInt8] {
        if #available(iOS 13.0, *) {
            return CryptoKit.SHA512.hash(data: self).makeIterator().filter { _ in true }
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            var ctx = CC_SHA512_CTX()
            _ = CC_SHA512_Init(&ctx)
            CC_SHA512_Update(&ctx, self.filter { _ in true }, CC_LONG(self.count))
            _ = withUnsafeMutablePointer(to: &digest[0], {
                CC_SHA512_Final($0, &ctx)
            })
            return digest
        }
    }

    public func MD5(lowercase: Bool) -> String {
        if #available(iOS 13.0, *) {
            return CryptoKit.Insecure.MD5.hash(data: self).makeIterator().xcup_ToHexString(lowercase)
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            var ctx = CC_MD5_CTX()
            CC_MD5_Init(&ctx)
            CC_MD5_Update(&ctx, self.filter { _ in true }, CC_LONG(self.count))
            _ = withUnsafeMutablePointer(to: &digest[0]) {
                CC_MD5_Final($0, &ctx)
            }
            return digest.xcup_ToHexString(lowercase)
        }
    }

    public func SHA256(lowercase: Bool) -> String {
        if #available(iOS 13.0, *) {
            return CryptoKit.SHA256.hash(data: self).makeIterator().xcup_ToHexString(lowercase)
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            var ctx = CC_SHA256_CTX()
            _ = CC_SHA256_Init(&ctx)
            CC_SHA256_Update(&ctx, self.filter { _ in true } , CC_LONG(self.count))
            _ = withUnsafeMutablePointer(to: &digest[0], {
                CC_SHA256_Final($0, &ctx)
            })
            return digest.xcup_ToHexString(lowercase)
        }
    }

    public func SHA512(lowercase: Bool) -> String {
        if #available(iOS 13.0, *) {
            return CryptoKit.SHA512.hash(data: self).makeIterator().xcup_ToHexString(lowercase)
        } else {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            var ctx = CC_SHA512_CTX()
            _ = CC_SHA512_Init(&ctx)
            CC_SHA512_Update(&ctx, self.filter { _ in true }, CC_LONG(self.count))
            _ = withUnsafeMutablePointer(to: &digest[0], {
                CC_SHA512_Final($0, &ctx)
            })
            return digest.xcup_ToHexString(lowercase)
        }
    }

}

@objc extension NSString {

    public func MD5Array(_ lowercase: Bool = true) -> NSArray {
        let s = (self as String) as XCUPDigesting
        return s.MD5(lowercase: lowercase) as NSArray
    }
    
    public func MD5(_ lowercase: Bool = true) -> NSString {
        let s = (self as String) as XCUPDigesting
        return s.MD5(lowercase: lowercase) as NSString
    }
    
    public func SHA256(_ lowercase: Bool = true) -> NSString {
        let s = (self as String) as XCUPDigesting
        return s.SHA256(lowercase: lowercase) as NSString
    }
    
    public func SHA512(_ lowercase: Bool = true) -> NSString {
        let s = (self as String) as XCUPDigesting
        return s.SHA512(lowercase: lowercase) as NSString
    }
    
}

extension String: XCUPDigesting {
    public func MD5(lowercase: Bool) -> [UInt8] {
        return self.data(using: .utf8)?.MD5(lowercase: lowercase) ?? []
    }

    public func SHA256(lowercase: Bool) -> [UInt8] {
        return self.data(using: .utf8)?.SHA256(lowercase: lowercase) ?? []
    }

    public func SHA512(lowercase: Bool) -> [UInt8] {
        return self.data(using: .utf8)?.SHA512(lowercase: lowercase) ?? []
    }

	public func MD5(lowercase: Bool = true) -> String {
        return self.data(using: .utf8)?.MD5(lowercase: lowercase) ?? ""
	}

	public func SHA256(lowercase: Bool = true) -> String {
        return self.data(using: .utf8)?.SHA256(lowercase: lowercase) ?? ""
	}

	public func SHA512(lowercase: Bool = true) -> String {
        return self.data(using: .utf8)?.SHA512(lowercase: lowercase) ?? ""
	}

}

class SignedURL: NSURL {
	var signName = "sign"
}

extension NSURL: XCURLSigning {

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

    @available(macOS 10.10, *)
    public func sign(with algo: (String) -> String, isAscending: Bool = true) -> URL? {
		let shortUrl = String(format: "%@://%@%@", (self.scheme != nil) ? self.scheme! : "", (self.host != nil) ? self.host! : "", (self.path != nil) ? self.path! : "")

		let queryString = self.sortedQuery(isAscending: isAscending)

		let absoluteString = String(format: "%@\(queryString.count > 0 ? "?" : "")%@", shortUrl, queryString )

		let signature = algo(absoluteString)
		
		if let url = self as? SignedURL {
            return Foundation.URL(string: "\(absoluteString)&\(url.signName)=\(signature)")
		}else {
            return Foundation.URL(string: "\(absoluteString)&sign=\(signature)")
		}
	}

    @available(macOS 10.10, *)
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
    
    @available(macOS 10.10, *)
    func sign(with algo: (String) -> String, isAscending: Bool) -> URL? {
        return self.NSURL()?.sign(with: algo, isAscending: isAscending) as URL?
    }
    
    @available(macOS 10.10, *)
    func sortedQuery(isAscending: Bool) -> String {
        return self.NSURL()?.sortedQuery(isAscending: isAscending) ?? ""
    }
    
	public func NSURL() -> Foundation.NSURL? {
		return Foundation.NSURL(string: self.absoluteString)
	}
}
