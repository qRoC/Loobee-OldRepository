// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
@testable import Loobee
import Foundation

class AtomicPerformanceTests: XCTestCase {
    static var allTests = [
        ("testPerformanceStore", testPerformanceStore),
        ("testPerformanceSynchronizedStore", testPerformanceSynchronizedStore),
        ("testPerformanceLoad", testPerformanceLoad),
        ("testPerformanceSynchronizedLoad", testPerformanceSynchronizedLoad),
        ("testPerformanceCASSuccess", testPerformanceCASSuccess),
        ("testPerformanceCASFailure", testPerformanceCASFailure)
    ]

    public func testPerformanceStore() {
        var atomic = AtomicInt32(0)
        measure {
            atomic.store(0)
            for i: Int32 in 0..<10_000_000 {
                _ = atomic.store(i, order: .relaxed)
            }
        }
    }

    public func testPerformanceSynchronizedStore() {
        var atomic = AtomicInt32(0)
        measure {
            atomic.store(0)
            for i: Int32 in 0..<10_000_000 {
                _ = atomic.store(i, order: .seqCst)
            }
        }
    }

    public func testPerformanceLoad() {
        var atomic = AtomicInt32(0)
        measure {
            atomic.store(0)
            for _ in 0..<10_000_000 {
                _ = atomic.load(order: .relaxed)
            }
        }
    }

    public func testPerformanceSynchronizedLoad() {
        var atomic = AtomicInt32(0)
        measure {
            atomic.store(0)
            for _ in 0..<10_000_000 {
                _ = atomic.load(order: .seqCst)
            }
        }
    }

    func testPerformanceCASSuccess() {
        var atomic = AtomicInt32(0)
        measure {
            atomic.store(0)
            for var i: Int32 in atomic.load(order: .relaxed)..<10_000_000 {
                _ = atomic.compareExchangeWeak(expected: &i, desired: i + 1)
            }
        }

        print(atomic.load(order: .relaxed))
    }

    func testPerformanceCASFailure() {
        var atomic = AtomicInt32(0)
        measure {
            atomic.store(0)
            for var i: Int32 in atomic.load(order: .relaxed)..<10_000_000 {
                _ = atomic.compareExchangeWeak(expected: &i, desired: 0)
            }
        }

        print(atomic.load(order: .relaxed))
    }
}
