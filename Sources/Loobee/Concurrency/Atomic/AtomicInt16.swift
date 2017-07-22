// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt16: Atomic, AtomicArithmetic, AtomicBitwise {
    @_versioned var val: Int16

    @inline(__always)
    public init(_ value: Int16) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicInt16_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: Int16, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt16_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(_ desired: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int16,
            desired: Int16,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt16_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int16,
            desired: Int16,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int16,
            desired: Int16,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt16_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int16,
            desired: Int16,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func fetchAndAdd(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndAdd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndSub(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndSub(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndAnd(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndAnd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndOr(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndOr(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndXor(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_fetchAndXor(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func addAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_addAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func subAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_subAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func andAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_andAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func orAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_orAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func xorAndFetch(_ operand: Int16, order: AtomicOrder = .seqCst) -> Int16 {
        return LoobeeCAtomicInt16_xorAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public static func +=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.addAndFetch(rhs)
    }

    @inline(__always)
    public static func -=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.subAndFetch(rhs)
    }

    @inline(__always)
    public static func &=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.andAndFetch(rhs)
    }

    @inline(__always)
    public static func |=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.orAndFetch(rhs)
    }

    @inline(__always)
    public static func ^=(lhs: inout AtomicInt16, rhs: Int16) {
        _ = lhs.xorAndFetch(rhs)
    }
}
