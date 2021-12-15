//
//  UIImage+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2021/12/15.
//

import Foundation

extension UIImage {
	func saveToJpeg(_ pathURL:URL, quality:CGFloat = 1.0) -> Bool {
		if let data = self.jpegData(compressionQuality: quality) {
			do {
				try data.write(to: pathURL)
			}
			catch {
				return false
			}
			return true
		}
		return false
	}

	func saveToPng(_ pathURL:URL) -> Bool {
		if let data = self.pngData() {
			do {
				try data.write(to: pathURL)
			}
			catch  {
				return false
			}
			return true
		}
		return false
	}
}
