//
//  Concurrency+XCUP.swift
//  XCocoaUtilsPublic
//
//  Created by Nicholas Xu on 2022/1/3.
//

import Foundation

public final class NXSynchronize<T> where T: NSLocking {
	private var _lock: T?

	public init(_ lock: T) {
		_lock = lock
		_lock?.lock()
	}

	deinit {
		_lock?.unlock()
	}
}

func syncOnMain(_ worker: () -> Void) {
	if Thread.isMainThread {
		worker()
	} else {
		DispatchQueue.main.sync(execute: worker)
	}
}

enum NXQueue: Int {
	case main = 0
	case concurrent = 1
	case serial = 2
}

public class NXQueueKey: NSObject {
	fileprivate let key = DispatchSpecificKey<Int>()
}

public struct NXConcurrency {
	fileprivate static var maxQID: Int = NXQueue.serial.rawValue + 1

	fileprivate static let mainQueueKey = DispatchSpecificKey<Int>()
	fileprivate static var mainBit: Int = 0

	fileprivate static let concurrentQueueKey = DispatchSpecificKey<Int>()
	fileprivate static var concurrentBit: Int = 1
	private static var concurrentQueue: DispatchQueue = {
		var q = DispatchQueue.init(label: "com.dehengxu.nx-concurrent-queue", qos: Dispatch.DispatchQoS.userInteractive, attributes: [.concurrent], autoreleaseFrequency: Dispatch.DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
		q.setSpecific(key: NXConcurrency.concurrentQueueKey, value: concurrentBit)
		return q
	}()

	fileprivate static let serialQueueKey = DispatchSpecificKey<Int>()
	fileprivate static var serialBit: Int = 2
	private static let serialQueue: DispatchQueue = {
		var q = DispatchQueue.init(label: "com.dehengxu.nx-serial-queue", qos: Dispatch.DispatchQoS.userInteractive, attributes: [], autoreleaseFrequency: Dispatch.DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
		q.setSpecific(key: serialQueueKey, value: serialBit)
		return q
	}()

	private static var dispatchQueues: [NXQueueKey: DispatchQueue] = [:]

	private static func register(user dispatchQueue: DispatchQueue, maxID: Int) -> NXQueueKey {
		let key = NXQueueKey()
		dispatchQueue.setSpecific(key: key.key, value: maxID)
		return key
	}

	public static func register(user dispatchQueue: DispatchQueue) -> NXQueueKey {
		let key = self.register(user: dispatchQueue, maxID: maxQID)
		return key
	}

	public static func queue(of queueKey: NXQueueKey) -> DispatchQueue? {
		return self.dispatchQueues[queueKey]
	}

	static func queue(_ queue: NXQueue) -> DispatchQueue {
		if DispatchQueue.main.getSpecific(key: Self.mainQueueKey) == nil {
			DispatchQueue.main.setSpecific(key: Self.mainQueueKey, value: Self.mainBit)
		}
		switch queue {
			case .main:
				return .main
			case .concurrent:
				return Self.concurrentQueue
			case .serial:
				return Self.serialQueue
		}
	}
}

private func internalKey(queue: NXQueue = .main) -> DispatchSpecificKey<Int> {
	let pkey: DispatchSpecificKey<Int>
	switch queue {
		case .serial:
			pkey = NXConcurrency.serialQueueKey
		case .concurrent:
			pkey = NXConcurrency.concurrentQueueKey
		default:
			pkey = NXConcurrency.mainQueueKey
			break
	}
	return pkey
}

func async(onUser queueKey: NXQueueKey, _ worker: @escaping () -> Void) {
	guard let q = NXConcurrency.queue(of: queueKey) else {
		return
	}
	q.async(execute: worker)
}

func sync(onUser queueKey: NXQueueKey, _ worker: @escaping () -> Void) {
	guard let q = NXConcurrency.queue(of: queueKey) else {
		return
	}
	if let bit = DispatchQueue.getSpecific(key: queueKey.key) {
		if bit == q.getSpecific(key: queueKey.key) {
			worker()
		}
	}
	q.sync(execute: worker)
}

func async(on queue: NXQueue = .main, _ worker: @escaping (() -> Void)) {
	let q: DispatchQueue = NXConcurrency.queue(queue)
	q.async(execute: worker)
}

func sync(on queue: NXQueue = .main, _ worker: @escaping (() -> Void)) {
	let q: DispatchQueue = NXConcurrency.queue(queue)
	if let bit = DispatchQueue.getSpecific(key: NXConcurrency.serialQueueKey) {
		if bit == NXConcurrency.serialBit {
			worker()
			return
		}
	}
	if Thread.isMainThread {
		worker()
		return
	}
	q.sync(execute: worker)
}
