//
//  Object+Extensions.swift
//  VE
//
//  Created by NicholasXu on 2021/11/12.
//  Copyright © 2021 Copyright © 2021 NicholasXu. All rights reserved.
//

import Foundation
import UIKit

public protocol Configuring {}

public extension Configuring where Self: Any {

    @discardableResult
    func configure(_ configure: ((_ target: Self) -> Void)?) -> Self {
        configure?(self)
        return self
    }
}

//extension Configuring where Self: Any {
//    static public func configure(_ configure: ((_ target: Self.Type) -> Void)?) -> Any {
//        configure?(Self.self as! Self)
//        return Self.self
//    }
//}

extension Swift.Optional: Configuring {}
extension NSObject: Configuring {}

public protocol AssocitedObject {}
extension AssocitedObject where Self: Any {
    subscript(key: NSString) -> Any? {
        set {
            objc_setAssociatedObject(self, Unmanaged.passUnretained(key).toOpaque()
                                     , newValue, .OBJC_ASSOCIATION_RETAIN)
            //print("save subscript: \(key), \(newValue)")
        }
        get {
            let v = objc_getAssociatedObject(self, Unmanaged.passUnretained(key).toOpaque())
            //print("get subscript: \(key), \(v)")
            return v
        }
    }

    subscript<ValueType>(key: NSString) -> ValueType? {
        set {
            objc_setAssociatedObject(self, Unmanaged.passUnretained(key).toOpaque()
                                     , newValue, .OBJC_ASSOCIATION_RETAIN)
            //print("save subscript: \(key), \(newValue)")
        }
        get {
            let v = objc_getAssociatedObject(self, Unmanaged.passUnretained(key).toOpaque())
            //print("get subscript: \(key), \(v)")
            return v as? ValueType
        }
    }
}
extension NSObject: AssocitedObject {}
