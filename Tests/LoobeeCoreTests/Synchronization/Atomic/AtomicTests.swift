// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import XCTest
import LoobeeCore

class AtomicTests: XCTestCase {
    func testIsAlwaysLockFree() {
        XCTAssertEqual(Atomic<Int>.isAlwaysLockFree(), Int.isAlwaysLockFree())
    }

    func testStore() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .release, .seqCst] {
            obj1.store(1, withOrder: order)
            obj2.atomicStore(1, withOrder: order)
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        obj1.store(1)
        obj2.atomicStore(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testLoad() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .seqCst] {
            XCTAssertEqual(obj1.load(withOrder: order), obj2.atomicLoad(withOrder: order))
        }

        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testExchange() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .acquire, .release, .acqRel, .seqCst] {
            let result1 = obj1.exchange(newValue: 1, withOrder: order)
            let result2 = obj2.atomicExchange(newValue: 1, withOrder: order)
            XCTAssertEqual(result1, result2)
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        let result1 = obj1.exchange(newValue: 1)
        let result2 = obj2.atomicExchange(newValue: 1)
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testCompareAndExchangeWeak() {
        let obj1 = Atomic(1)
        var obj2 = 1

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeWeak(
                    expected: &expected1,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                let result2 = obj2.atomicCompareAndExchangeWeak(
                    expected: &expected2,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeWeak(
                    expected: &expected1,
                    desired: 1,
                    withOrder: order
                )
                let result2 = obj2.atomicCompareAndExchangeWeak(
                    expected: &expected2,
                    desired: 1,
                    withOrder: order
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        var expected1 = 0
        var expected2 = 0
        let result1 = obj1.compareAndExchangeWeak(
            expected: &expected1,
            desired: 1
        )
        let result2 = obj2.atomicCompareAndExchangeWeak(
            expected: &expected2,
            desired: 1
        )
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testCompareAndExchangeStrong() {
        let obj1 = Atomic(1)
        var obj2 = 1

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeStrong(
                    expected: &expected1,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                let result2 = obj2.atomicCompareAndExchangeStrong(
                    expected: &expected2,
                    desired: 1,
                    successOrder: order,
                    failureOrder: .relaxed
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        do {
            var expected1 = 0
            var expected2 = 0
            for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
                let result1 = obj1.compareAndExchangeStrong(
                    expected: &expected1,
                    desired: 1,
                    withOrder: order
                )
                let result2 = obj2.atomicCompareAndExchangeStrong(
                    expected: &expected2,
                    desired: 1,
                    withOrder: order
                )
                XCTAssertEqual(result1, result2)
                XCTAssertEqual(obj1.load(), obj2.atomicLoad())
            }
        }

        var expected1 = 0
        var expected2 = 0
        let result1 = obj1.compareAndExchangeStrong(
            expected: &expected1,
            desired: 1
        )
        let result2 = obj2.atomicCompareAndExchangeStrong(
            expected: &expected2,
            desired: 1
        )
        XCTAssertEqual(result1, result2)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndAdd() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndAdd(1, withOrder: order),
                obj2.atomicFetchAndAdd(1, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndAdd(1),
            obj2.atomicFetchAndAdd(1)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 += 1
        _ = obj2.atomicFetchAndAdd(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 += Atomic(1)
        _ = obj2.atomicFetchAndAdd(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }

    func testFetchAndSub() {
        let obj1 = Atomic(1)
        var obj2 = 1

        for order: AtomicOrder in [.relaxed, .consume, .acquire, .release, .acqRel, .seqCst] {
            XCTAssertEqual(
                obj1.fetchAndSub(1, withOrder: order),
                obj2.atomicFetchAndSub(1, withOrder: order)
            )
            XCTAssertEqual(obj1.load(), obj2.atomicLoad())
        }

        XCTAssertEqual(
            obj1.fetchAndSub(1),
            obj2.atomicFetchAndSub(1)
        )
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 -= 1
        _ = obj2.atomicFetchAndSub(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())

        obj1 -= Atomic(1)
        _ = obj2.atomicFetchAndSub(1)
        XCTAssertEqual(obj1.load(), obj2.atomicLoad())
    }
}


//    /// Calls the `T.atomicSubAndFetch(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicArithmeticContract.atomicSubAndFetch(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func subAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicSubAndFetch(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicSubAndFetch(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicArithmeticContract.atomicSubAndFetch(_:)`
//    @inlinable
//    @inline(__always)
//    public func subAndFetch(_ value: T) -> T {
//        return self.value.atomicSubAndFetch(value)
//    }
//
//    /// Alias of `subAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    public static func -=(lhs: Atomic<T>, rhs: T) {
//        _ = lhs.subAndFetch(rhs)
//    }
//
//    /// Alias of `subAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    public static func -=(lhs: Atomic<T>, rhs: Atomic<T>) {
//        _ = lhs.subAndFetch(rhs.load())
//    }
//}
//
//public extension Atomic where T: AtomicBitwiseContract {
//    /// Calls the `T.atomicFetchAndBitAnd(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitAnd(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func fetchAndBitAnd(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicFetchAndBitAnd(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicFetchAndBitAnd(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitAnd(_:)`
//    @inlinable
//    @inline(__always)
//    public func fetchAndBitAnd(_ value: T) -> T {
//        return self.value.atomicFetchAndBitAnd(value)
//    }
//
//    /// Calls the `T.atomicFetchAndBitOr(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitOr(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func fetchAndBitOr(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicFetchAndBitOr(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicFetchAndBitOr(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitOr(_:)`
//    @inlinable
//    @inline(__always)
//    public func fetchAndBitOr(_ value: T) -> T {
//        return self.value.atomicFetchAndBitOr(value)
//    }
//
//    /// Calls the `T.atomicFetchAndBitXor(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitXor(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func fetchAndBitXor(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicFetchAndBitXor(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicFetchAndBitXor(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitXor(_:)`
//    @inlinable
//    @inline(__always)
//    public func fetchAndBitXor(_ value: T) -> T {
//        return self.value.atomicFetchAndBitXor(value)
//    }
//
//    /// Calls the `T.atomicBitAndAndFetch(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicBitAndAndFetch(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func bitAndAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicBitAndAndFetch(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicBitAndAndFetch(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicBitAndAndFetch(_:)`
//    @inlinable
//    @inline(__always)
//    public func bitAndAndFetch(_ value: T) -> T {
//        return self.value.atomicBitAndAndFetch(value)
//    }
//
//    /// Alias of `bitAndAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    internal static func &=(lhs: Atomic<T>, rhs: T) {
//        _ = lhs.bitAndAndFetch(rhs)
//    }
//
//    /// Alias of `bitAndAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    internal static func &=(lhs: Atomic<T>, rhs: Atomic<T>) {
//        _ = lhs.bitAndAndFetch(rhs.load())
//    }
//
//    /// Calls the `T.atomicBitOrAndFetch(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicBitOrAndFetch(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func bitOrAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicBitOrAndFetch(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicBitOrAndFetch(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicBitOrAndFetch(_:)`
//    @inlinable
//    @inline(__always)
//    public func bitOrAndFetch(_ value: T) -> T {
//        return self.value.atomicBitOrAndFetch(value)
//    }
//
//    /// Alias of `bitOrAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    internal static func |=(lhs: Atomic<T>, rhs: T) {
//        _ = lhs.bitOrAndFetch(rhs)
//    }
//
//    /// Alias of `bitOrAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    internal static func |=(lhs: Atomic<T>, rhs: Atomic<T>) {
//        _ = lhs.bitOrAndFetch(rhs.load())
//    }
//
//    /// Calls the `T.atomicBitXorAndFetch(_:withOrder:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicBitXorAndFetch(_:withOrder:)`
//    @inlinable
//    @inline(__always)
//    public func bitXorAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
//        return self.value.atomicBitXorAndFetch(value, withOrder: order)
//    }
//
//    /// Calls the `T.atomicBitXorAndFetch(_:)` method.
//    ///
//    /// - SeeAlso: `AtomicBitwiseContract.atomicBitXorAndFetch(_:)`
//    @inlinable
//    @inline(__always)
//    public func bitXorAndFetch(_ value: T) -> T {
//        return self.value.atomicBitXorAndFetch(value)
//    }
//
//    /// Alias of `bitXorAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    internal static func ^=(lhs: Atomic<T>, rhs: T) {
//        _ = lhs.bitXorAndFetch(rhs)
//    }
//
//    /// Alias of `bitXorAndFetch(_:)` method.
//    @inlinable
//    @inline(__always)
//    internal static func ^=(lhs: Atomic<T>, rhs: Atomic<T>) {
//        _ = lhs.bitXorAndFetch(rhs.load())
//    }
//}
