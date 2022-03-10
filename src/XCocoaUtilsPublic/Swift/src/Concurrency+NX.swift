//
//  SwiftFunctions.swift
//
//  Created by NicholasXu on 2021/10/22.
//

import Foundation

public func sychronized(_ lock: NSLocking, work: () -> Void) {
    lock.lock()
    defer {
        lock.unlock()
    }
    work()
}

public class NXDispatchSpecificKeyWrapper<T>: NSObject where T: Hashable {
    public private(set) var specificKey: DispatchSpecificKey<T>
    public private(set) var specificValue: T
    public private(set) var queue: DispatchQueue

    public init(queue: DispatchQueue, value: T) {
        self.queue = queue
        specificValue = value
        specificKey = DispatchSpecificKey<T>()
        //print("init: \(specificKey), \(specificValue)")
        self.queue.setSpecific(key: specificKey, value: specificValue)
    }

    static func == (lhs: NXDispatchSpecificKeyWrapper, rhs: NXDispatchSpecificKeyWrapper) -> Bool {
        return lhs.queue == rhs.queue
    }

    public override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Self {
            return obj.queue.isEqual(self.queue)
        }
        return false
    }

    public override var hash: Int {
        get {
            return queue.hashValue
        }
    }

    public override var description: String {
        return "\(self.classForCoder) ( key: \(self.specificKey), value: \(specificValue) )"
    }

}

@objc(NXConcurrency)
public  class NXConcurrency: NSObject {

    fileprivate static var queueBits: Set<NXDispatchSpecificKeyWrapper<Int>> = []

    @objc public static func register(_ queue: DispatchQueue) {
        register(queue, specificValue: queueBits.count)
    }

    @objc private static func register(_ queue: DispatchQueue, specificValue: Int) {
        let wrapper = NXDispatchSpecificKeyWrapper(queue: queue, value: specificValue)
        let (inserted, _) = queueBits.insert(wrapper)
        if !inserted {
            //#if DEBUG
            //fatalError("Register duplicated.")
            //#else
            print("Register duplicated.")
            //#endif
        }
    }

    @objc public static func currentDispatchQueues() -> [DispatchQueue] {
        var queues: [DispatchQueue] = []

        for wrapper in queueBits {
            // print("\(#function), wrapper: \(wrapper)")
            if let _ = DispatchQueue.getSpecific(key: wrapper.specificKey), let _ = wrapper.queue.getSpecific(key: wrapper.specificKey) {
                queues.append(wrapper.queue)
            }
        }

        return queues
    }

    @objc public static func isCurrent(_ queue: DispatchQueue) -> Bool {
        var hasRegistered = false
        for wrapper in queueBits {
            // print("\(#function), wrapper: \(wrapper)")
            if !hasRegistered && wrapper.queue == queue {
                hasRegistered = true
            }
            if let _ = DispatchQueue.getSpecific(key: wrapper.specificKey), let _ = wrapper.queue.getSpecific(key: wrapper.specificKey), let _ = queue.getSpecific(key: wrapper.specificKey) {
                return true
            }
        }

        if !hasRegistered {
            print("queue has no been registered")
        }

        return false
    }

    @objc public static func setupDefaultQueues() {
        self.register(DispatchQueue.main)
        self.register(DispatchQueue.global(qos: .default))
        self.register(DispatchQueue.global(qos: .utility))
        self.register(DispatchQueue.global(qos: .userInteractive))
        self.register(DispatchQueue.global(qos: .userInitiated))
        self.register(DispatchQueue.global(qos: .background))
    }
}

public extension DispatchQueue {

    convenience init(register: Bool, label: String) {
        self.init(label: label)
        if register {
            NXConcurrency.register(self)
        }
    }

    convenience init(register: Bool, label: String, qos: DispatchQoS, attributes: DispatchQueue.Attributes, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency, target: DispatchQueue) {
        self.init(label: label, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: target)
        if register {
            NXConcurrency.register(self)
        }
    }

    func isSerial() -> Bool {
        return self is OS_dispatch_queue_serial
    }

    func isCurrent() -> Bool {
        return NXConcurrency.isCurrent(self)
    }

}

public func sync(on queue: DispatchQueue, _ worker: (() -> Void)) {
    if queue.isCurrent() /*&& queue.isSerial()*/ {
        // Current queue is serialize queue run worker directly
        worker()
    } else {
        queue.sync(execute: worker)
    }
}

public func async(on queue: DispatchQueue, _  worker: @escaping (() -> Void)) {
//    if queue.isCurrent() /*&& !queue.isSerial()*/ {
//        worker()
//    } else {
        queue.async(execute: worker)
//    }
}

final class AtomicCounter: NSLock {
    private var counter: Int = 0
    init(value: Int = 0) {
        super.init()
        counter = value
    }

    func value() -> Int {
        self.lock()
        defer {
            self.unlock()
        }
        return counter
    }

    func increase(by: Int) -> Int {
        self.lock()
        defer {
            self.unlock()
        }
        counter += by
        return counter
    }

    func decrease(by: Int) -> Int {
        self.lock()
        defer {
            self.unlock()
        }
        counter -= by
        return counter
    }

    func multiply(by: Int) -> Int {
        self.lock()
        defer {
            self.unlock()
        }
        counter *= by
        return counter
    }

    func divid(by: Int) -> Int {
        self.lock()
        defer {
            self.unlock()
        }
        counter /= by
        return counter
    }

}

