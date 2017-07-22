// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt32: Atomic, AtomicArithmetic, AtomicBitwise {
    @_versioned var val: Int32

    @inline(__always)
    public init(_ value: Int32) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicInt32_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: Int32, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt32_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(_ desired: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int32,
            desired: Int32,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt32_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int32,
            desired: Int32,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int32,
            desired: Int32,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt32_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int32,
            desired: Int32,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func fetchAndAdd(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_fetchAndAdd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndSub(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_fetchAndSub(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndAnd(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_fetchAndAnd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndOr(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_fetchAndOr(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndXor(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_fetchAndXor(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func addAndFetch(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_addAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func subAndFetch(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_subAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func andAndFetch(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_andAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func orAndFetch(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_orAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func xorAndFetch(_ operand: Int32, order: AtomicOrder = .seqCst) -> Int32 {
        return LoobeeCAtomicInt32_xorAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public static func +=(lhs: inout AtomicInt32, rhs: Int32) {
        _ = lhs.addAndFetch(rhs)
    }

    @inline(__always)
    public static func -=(lhs: inout AtomicInt32, rhs: Int32) {
        _ = lhs.subAndFetch(rhs)
    }

    @inline(__always)
    public static func &=(lhs: inout AtomicInt32, rhs: Int32) {
        _ = lhs.andAndFetch(rhs)
    }

    @inline(__always)
    public static func |=(lhs: inout AtomicInt32, rhs: Int32) {
        _ = lhs.orAndFetch(rhs)
    }

    @inline(__always)
    public static func ^=(lhs: inout AtomicInt32, rhs: Int32) {
        _ = lhs.xorAndFetch(rhs)
    }
}
