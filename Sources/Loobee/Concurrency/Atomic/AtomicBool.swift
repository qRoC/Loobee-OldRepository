// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicBool: Atomic {
    @_versioned var val: Bool

    @inline(__always)
    public init(_ value: Bool) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicBool_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: Bool, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicBool_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> Bool {
        return LoobeeCAtomicBool_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(_ desired: Bool, order: AtomicOrder = .seqCst) -> Bool {
        return LoobeeCAtomicBool_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Bool,
            desired: Bool,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicBool_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Bool,
            desired: Bool,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Bool,
            desired: Bool,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicBool_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Bool,
            desired: Bool,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }
}
