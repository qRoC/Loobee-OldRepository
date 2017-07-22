// This file is part of the Loobee package.
//
// (c) Andrey Savitsky <contact@qroc.pro>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.

import LoobeeCAtomic

public struct AtomicInt64: Atomic, AtomicArithmetic, AtomicBitwise {
    @_versioned var val: Int64

    @inline(__always)
    public init(_ value: Int64) {
        val = value
    }

    @inline(__always)
    public static func isAlwaysLockFree() -> Bool {
        return LoobeeCAtomicInt64_isLockFree
    }

    @inline(__always)
    public mutating func store(_ desired: Int64, order: AtomicOrder = .seqCst) {
        LoobeeCAtomicInt64_store(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func load(order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_load(&val, order: order)
    }

    @inline(__always)
    public mutating func exchange(_ desired: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_exchange(&val, desired: desired, order: order)
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int64,
            desired: Int64,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt64_compareExchangeWeak(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeWeak(
            expected: inout Int64,
            desired: Int64,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeWeak(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int64,
            desired: Int64,
            successOrder: AtomicOrder,
            failureOrder: AtomicOrder
    ) -> Bool {
        return LoobeeCAtomicInt64_compareExchangeStrong(
                &val,
                expected: &expected,
                desired: desired,
                successOrder: successOrder,
                failureOrder: failureOrder
        )
    }

    @inline(__always)
    public mutating func compareExchangeStrong(
            expected: inout Int64,
            desired: Int64,
            order: AtomicOrder = .seqCst
    ) -> Bool {
        return compareExchangeStrong(expected: &expected, desired: desired, successOrder: order, failureOrder: order)
    }

    @inline(__always)
    public mutating func fetchAndAdd(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndAdd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndSub(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndSub(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndAnd(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndAnd(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndOr(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndOr(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func fetchAndXor(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_fetchAndXor(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func addAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_addAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func subAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_subAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func andAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_andAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func orAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_orAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public mutating func xorAndFetch(_ operand: Int64, order: AtomicOrder = .seqCst) -> Int64 {
        return LoobeeCAtomicInt64_xorAndFetch(&val, op: operand, order: order)
    }

    @inline(__always)
    public static func +=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.addAndFetch(rhs)
    }

    @inline(__always)
    public static func -=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.subAndFetch(rhs)
    }

    @inline(__always)
    public static func &=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.andAndFetch(rhs)
    }

    @inline(__always)
    public static func |=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.orAndFetch(rhs)
    }

    @inline(__always)
    public static func ^=(lhs: inout AtomicInt64, rhs: Int64) {
        _ = lhs.xorAndFetch(rhs)
    }
}
