// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

/// Wrapper for atomic primitive type with safe copied.
public final class Atomic<T: AtomicContract> {
    @usableFromInline
    internal var value: T

    /// Create an atomic object with `value`.
    @inlinable
    @inline(__always)
    public init(_ value: T) {
        self.value = value
    }

    /// Calls the `T.isAlwaysLockFree()` method.
    ///
    /// - SeeAlso: `AtomicContract.isAlwaysLockFree()`
    @inlinable
    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return T.isAlwaysLockFree()
    }

    /// Calls the `T.atomicStore(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicStore(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func store(_ value: T, withOrder order: AtomicOrder) {
        self.value.atomicStore(value, withOrder: order)
    }

    /// Calls the `T.atomicStore(_:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicStore(_:)`
    @inlinable
    @inline(__always)
    public func store(_ value: T) {
        self.value.atomicStore(value)
    }

    /// Calls the `T.atomicLoad(withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicLoad(withOrder:)`
    @inlinable
    @inline(__always)
    public func load(withOrder order: AtomicOrder) -> T {
        return self.value.atomicLoad(withOrder: order)
    }

    /// Calls the `T.atomicLoad()` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicLoad()`
    @inlinable
    @inline(__always)
    public func load() -> T {
        return self.value.atomicLoad()
    }

    /// Calls the `T.atomicExchange(newValue:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicExchange(newValue:withOrder:)`
    @inlinable
    @inline(__always)
    public func exchange(newValue: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicExchange(newValue: newValue, withOrder: order)
    }

    /// Calls the `T.atomicExchange(newValue:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicExchange(newValue:)`
    @inlinable
    @inline(__always)
    public func exchange(newValue: T) -> T {
        return self.value.atomicExchange(newValue: newValue)
    }

    /// Calls the `T.atomicCompareAndExchangeWeak(expected:desired:successOrder:failureOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicCompareAndExchangeWeak(expected:desired:successOrder:failureOrder:)`
    @inlinable
    @inline(__always)
    public func compareAndExchangeWeak(
        expected: inout T,
        desired: T,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return self.value.atomicCompareAndExchangeWeak(
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }

    /// Calls the `T.atomicCompareAndExchangeWeak(expected:desired:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicCompareAndExchangeWeak(expected:desired:withOrder:)`
    @inlinable
    @inline(__always)
    public func compareAndExchangeWeak(
        expected: inout T,
        desired: T,
        withOrder order: AtomicOrder
        ) -> Bool {
        return self.value.atomicCompareAndExchangeWeak(
            expected: &expected,
            desired: desired,
            withOrder: order
        )
    }

    /// Calls the `T.atomicCompareAndExchangeWeak(expected:desired:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicCompareAndExchangeWeak(expected:desired:)`
    @inlinable
    @inline(__always)
    public func compareAndExchangeWeak(
        expected: inout T,
        desired: T
        ) -> Bool {
        return self.value.atomicCompareAndExchangeWeak(
            expected: &expected,
            desired: desired
        )
    }

    /// Calls the `T.atomicCompareAndExchangeStrong(expected:desired:successOrder:failureOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicCompareAndExchangeStrong(expected:desired:successOrder:failureOrder:)`
    @inlinable
    @inline(__always)
    public func compareAndExchangeStrong(
        expected: inout T,
        desired: T,
        successOrder: AtomicOrder,
        failureOrder: AtomicOrder
        ) -> Bool {
        return self.value.atomicCompareAndExchangeStrong(
            expected: &expected,
            desired: desired,
            successOrder: successOrder,
            failureOrder: failureOrder
        )
    }

    /// Calls the `T.atomicCompareAndExchangeStrong(expected:desired:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicCompareAndExchangeStrong(expected:desired:withOrder:)`
    @inlinable
    @inline(__always)
    public func compareAndExchangeStrong(
        expected: inout T,
        desired: T,
        withOrder order: AtomicOrder
        ) -> Bool {
        return self.value.atomicCompareAndExchangeStrong(
            expected: &expected,
            desired: desired,
            withOrder: order
        )
    }

    /// Calls the `T.atomicCompareAndExchangeStrong(expected:desired:)` method.
    ///
    /// - SeeAlso: `AtomicContract.atomicCompareAndExchangeStrong(expected:desired:)`
    @inlinable
    @inline(__always)
    public func compareAndExchangeStrong(
        expected: inout T,
        desired: T
        ) -> Bool {
        return self.value.atomicCompareAndExchangeStrong(
            expected: &expected,
            desired: desired
        )
    }
}

public extension Atomic where T: AtomicArithmeticContract {
    /// Calls the `T.atomicFetchAndAdd(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicFetchAndAdd(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func fetchAndAdd(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicFetchAndAdd(value, withOrder: order)
    }

    /// Calls the `T.atomicFetchAndAdd(_:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicFetchAndAdd(_:)`
    @inlinable
    @inline(__always)
    public func fetchAndAdd(_ value: T) -> T {
        return self.value.atomicFetchAndAdd(value)
    }

    /// Calls the `T.atomicFetchAndSub(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicFetchAndSub(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func fetchAndSub(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicFetchAndSub(value, withOrder: order)
    }

    /// Calls the `T.atomicFetchAndSub(_:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicFetchAndSub(_:)`
    @inlinable
    @inline(__always)
    public func fetchAndSub(_ value: T) -> T {
        return self.value.atomicFetchAndSub(value)
    }

    /// Calls the `T.atomicAddAndFetch(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicAddAndFetch(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func addAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicAddAndFetch(value, withOrder: order)
    }

    /// Calls the `T.atomicAddAndFetch(_:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicAddAndFetch(_:)`
    @inlinable
    @inline(__always)
    public func addAndFetch(_ value: T) -> T {
        return self.value.atomicAddAndFetch(value)
    }

    /// Alias of `addAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    public static func +=(lhs: Atomic<T>, rhs: T) {
        _ = lhs.addAndFetch(rhs)
    }

    /// Alias of `addAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    public static func +=(lhs: Atomic<T>, rhs: Atomic<T>) {
        _ = lhs.addAndFetch(rhs.load())
    }

    /// Calls the `T.atomicSubAndFetch(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicSubAndFetch(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func subAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicSubAndFetch(value, withOrder: order)
    }

    /// Calls the `T.atomicSubAndFetch(_:)` method.
    ///
    /// - SeeAlso: `AtomicArithmeticContract.atomicSubAndFetch(_:)`
    @inlinable
    @inline(__always)
    public func subAndFetch(_ value: T) -> T {
        return self.value.atomicSubAndFetch(value)
    }

    /// Alias of `subAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    public static func -=(lhs: Atomic<T>, rhs: T) {
        _ = lhs.subAndFetch(rhs)
    }

    /// Alias of `subAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    public static func -=(lhs: Atomic<T>, rhs: Atomic<T>) {
        _ = lhs.subAndFetch(rhs.load())
    }
}

public extension Atomic where T: AtomicBitwiseContract {
    /// Calls the `T.atomicFetchAndBitAnd(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitAnd(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func fetchAndBitAnd(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicFetchAndBitAnd(value, withOrder: order)
    }

    /// Calls the `T.atomicFetchAndBitAnd(_:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitAnd(_:)`
    @inlinable
    @inline(__always)
    public func fetchAndBitAnd(_ value: T) -> T {
        return self.value.atomicFetchAndBitAnd(value)
    }

    /// Calls the `T.atomicFetchAndBitOr(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitOr(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func fetchAndBitOr(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicFetchAndBitOr(value, withOrder: order)
    }

    /// Calls the `T.atomicFetchAndBitOr(_:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitOr(_:)`
    @inlinable
    @inline(__always)
    public func fetchAndBitOr(_ value: T) -> T {
        return self.value.atomicFetchAndBitOr(value)
    }

    /// Calls the `T.atomicFetchAndBitXor(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitXor(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func fetchAndBitXor(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicFetchAndBitXor(value, withOrder: order)
    }

    /// Calls the `T.atomicFetchAndBitXor(_:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicFetchAndBitXor(_:)`
    @inlinable
    @inline(__always)
    public func fetchAndBitXor(_ value: T) -> T {
        return self.value.atomicFetchAndBitXor(value)
    }

    /// Calls the `T.atomicBitAndAndFetch(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicBitAndAndFetch(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func bitAndAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicBitAndAndFetch(value, withOrder: order)
    }

    /// Calls the `T.atomicBitAndAndFetch(_:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicBitAndAndFetch(_:)`
    @inlinable
    @inline(__always)
    public func bitAndAndFetch(_ value: T) -> T {
        return self.value.atomicBitAndAndFetch(value)
    }

    /// Alias of `bitAndAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    internal static func &=(lhs: Atomic<T>, rhs: T) {
        _ = lhs.bitAndAndFetch(rhs)
    }

    /// Alias of `bitAndAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    internal static func &=(lhs: Atomic<T>, rhs: Atomic<T>) {
        _ = lhs.bitAndAndFetch(rhs.load())
    }

    /// Calls the `T.atomicBitOrAndFetch(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicBitOrAndFetch(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func bitOrAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicBitOrAndFetch(value, withOrder: order)
    }

    /// Calls the `T.atomicBitOrAndFetch(_:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicBitOrAndFetch(_:)`
    @inlinable
    @inline(__always)
    public func bitOrAndFetch(_ value: T) -> T {
        return self.value.atomicBitOrAndFetch(value)
    }

    /// Alias of `bitOrAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    internal static func |=(lhs: Atomic<T>, rhs: T) {
        _ = lhs.bitOrAndFetch(rhs)
    }

    /// Alias of `bitOrAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    internal static func |=(lhs: Atomic<T>, rhs: Atomic<T>) {
        _ = lhs.bitOrAndFetch(rhs.load())
    }

    /// Calls the `T.atomicBitXorAndFetch(_:withOrder:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicBitXorAndFetch(_:withOrder:)`
    @inlinable
    @inline(__always)
    public func bitXorAndFetch(_ value: T, withOrder order: AtomicOrder) -> T {
        return self.value.atomicBitXorAndFetch(value, withOrder: order)
    }

    /// Calls the `T.atomicBitXorAndFetch(_:)` method.
    ///
    /// - SeeAlso: `AtomicBitwiseContract.atomicBitXorAndFetch(_:)`
    @inlinable
    @inline(__always)
    public func bitXorAndFetch(_ value: T) -> T {
        return self.value.atomicBitXorAndFetch(value)
    }

    /// Alias of `bitXorAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    internal static func ^=(lhs: Atomic<T>, rhs: T) {
        _ = lhs.bitXorAndFetch(rhs)
    }

    /// Alias of `bitXorAndFetch(_:)` method.
    @inlinable
    @inline(__always)
    internal static func ^=(lhs: Atomic<T>, rhs: Atomic<T>) {
        _ = lhs.bitXorAndFetch(rhs.load())
    }
}
