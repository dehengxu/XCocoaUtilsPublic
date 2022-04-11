//
//  Number+Date.swift
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2022/4/11.
//

import Foundation

public extension Int {
    func dateStringSince1970(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter =  DateFormatter().configure { target in
            target.dateFormat = format
        }
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
