// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

// Waits [this] [1] proposal for `Atomic` protocol supports.
//
//   [1]: https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md
public struct AtomicRawPointer {
    @_versioned var val: UnsafeMutableRawPointer?

    @inline(__always)
    public init(_ value: UnsafeMutableRawPointer?) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicUnsafeMutableRawPointer_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: UnsafeMutableRawPointer?, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicUnsafeMutableRawPointer_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> UnsafeMutableRawPointer? {
        return LoobeeCAtomicUnsafeMutableRawPointer_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(
            _ desired: UnsafeMutableRawPointer?,
            order: AtomicOrder = .seqCst
    ) -> UnsafeMutableRawPointer? {
        return LoobeeCAtomicUnsafeMutableRawPointer_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout UnsafeMutableRawPointer?,
            desired: UnsafeMutableRawPointer?,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUnsafeMutableRawPointer_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout UnsafeMutableRawPointer?,
            desired: UnsafeMutableRawPointer?,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout UnsafeMutableRawPointer?,
            desired: UnsafeMutableRawPointer?,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicUnsafeMutableRawPointer_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout UnsafeMutableRawPointer?,
            desired: UnsafeMutableRawPointer?,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func fetchAndAdd(
            _ operand: Int,
            order: AtomicOrder = .seqCst
    ) -> UnsafeMutableRawPointer? {
        return LoobeeCAtomicUnsafeMutableRawPointer_fetchAndAdd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndSub(
            _ operand: Int,
            order: AtomicOrder = .seqCst
    ) -> UnsafeMutableRawPointer? {
        return LoobeeCAtomicUnsafeMutableRawPointer_fetchAndSub(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func addAndFetch(
            _ operand: Int,
            order: AtomicOrder = .seqCst
    ) -> UnsafeMutableRawPointer? {
        return LoobeeCAtomicUnsafeMutableRawPointer_addAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func subAndFetch(
            _ operand: Int,
            order: AtomicOrder = .seqCst
    ) -> UnsafeMutableRawPointer? {
        return LoobeeCAtomicUnsafeMutableRawPointer_subAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public static func +=(lhs: inout AtomicRawPointer, rhs: Int) {
        _ = lhs.addAndFetch(rhs)
    }

    @inline(__always)
    public static func -=(lhs: inout AtomicRawPointer, rhs: Int) {
        _ = lhs.subAndFetch(rhs)
    }
}
